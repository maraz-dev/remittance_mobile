import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/requests/send_money_to_bank_req.dart';
import 'package:remittance_mobile/view/features/home/account-view/exchange/exchange_transaction_detail.dart';
import 'package:remittance_mobile/view/features/home/widgets/validate_pin_sheet.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_from_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_how_much_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_to_who_view.dart';
import 'package:remittance_mobile/view/features/services/vm/send-money-vm/send_money_vm.dart';
import 'package:remittance_mobile/view/features/services/vm/send_to_bank_vm.dart';
import 'package:remittance_mobile/view/features/services/widgets/send_trx_details_card.dart';
import 'package:remittance_mobile/view/features/services/widgets/success_transaction_sheet.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/overlay_animation.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class SendMoneyDetailsView extends ConsumerStatefulWidget {
  static const path = 'send-money-detail-view';
  const SendMoneyDetailsView({super.key});

  @override
  ConsumerState<SendMoneyDetailsView> createState() => _SendMoneyDetailsViewState();
}

class _SendMoneyDetailsViewState extends ConsumerState<SendMoneyDetailsView> {
  String totalFee = '';
  @override
  void initState() {
    super.initState();
    totalFee =
        (double.parse(sourceAmount.value.replaceAll(',', '')) + (feeResponse.value.fee ?? 0.0))
            .toString();
  }

  @override
  Widget build(BuildContext context) {
    final sendMoneyLoading = ref.watch(sendToBankProvider).isLoading;
    final transferState = ref.watch(selectedTransferStateProvider);

    ref.listen(sendToBankProvider, (_, next) {
      if (next is AsyncData) {
        AppBottomSheet.showBottomSheet(
          context,
          isDismissible: false,
          enableDrag: false,
          widget: SuccessTranxSheet(
            amount: double.parse(sourceAmount.value.replaceAll(',', ''))
                .amountWithCurrency(transferState.sourceCurrency?.symbol ?? ''),
            accountDetails: '${selectedBeneficiary.value.accountName}',
            requestId: next.value?.requestId ?? "",
          ),
        );
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });

    return AbsorbPointer(
      absorbing: sendMoneyLoading,
      child: Scaffold(
        appBar: innerAppBar(title: 'Send Money'),
        body: OverlayLoadingIndicator(
          isLoading: sendMoneyLoading,
          child: ScaffoldBody(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  15.0.height,
                  Text(
                    'See details of your transaction below.',
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  16.0.height,

                  // Transaction Details
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SectionHeader(text: 'Transaction Details'),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.kWarningColor100,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                'Pending',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: AppColors.kWarningColor700),
                              ),
                            )
                          ],
                        ),
                        16.0.height,
                        TrxItems(
                          title: 'You are Sending',
                          description:
                              '${sourceAmount.value} ${transferState.sourceCurrency?.code}',
                        ),
                        16.0.height,
                        TrxItems(
                          title: 'At (rate)',
                          description:
                              '1 ${transferState.destinationCurrency?.code} - ${(1 / (feeResponse.value.rate ?? 1.0)).formatDecimal()} ${transferState.sourceCurrency?.code}',
                        ),
                        16.0.height,
                        TrxItems(
                          title: 'Bank Transfer fees',
                          description:
                              '${feeResponse.value.fee.formatDecimal()} ${transferState.sourceCurrency?.code}',
                        ),
                        16.0.height,
                        TrxItems(
                          title: 'Recipient receives',
                          description:
                              '${feeResponse.value.destinationAmount.formatDecimal()} ${transferState.destinationCurrency?.code}',
                        ),
                        16.0.height,
                        TrxItems(
                          title: 'You Pay',
                          description:
                              '${totalFee.formatDecimal()} ${transferState.sourceCurrency?.code}',
                        ),
                        16.0.height,

                        // Edit the How Much
                        InkWell(
                          onTap: () {
                            context.pop();
                            context.pop();
                          },
                          child: Text(
                            'Change',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.kPrimaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  16.0.height,

                  SendTrxDetailsCard(
                    heading: "Recipient",
                    icon: AppImages.accountDetails,
                    info: 'Bank Account',
                    title: selectedBeneficiary.value.accountName?.truncate(25) ?? 'John Doe',
                    subtitle:
                        '${selectedBeneficiary.value.accountNumber} · ${selectedBeneficiary.value.bankName}'
                            .truncate(29),
                    onPressed: () => context.pop(),
                  ),
                  24.0.height,
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          children: [
            MainButton(
              text: 'Send ${totalFee.formatDecimal()} ${transferState.sourceCurrency?.code}',
              isLoading: sendMoneyLoading,
              onPressed: () async {
                bool? res = await AppBottomSheet.showBottomSheet(
                  context,
                  isDismissible: true,
                  enableDrag: false,
                  widget: const ValidatePINSheet(),
                );
                if (res == null) return;
                if (res == true) {
                  ref.read(sendToBankProvider.notifier).sendToBankMethod(
                        SendToBankReq(
                          bankCode: selectedBeneficiary.value.bankCode,
                          destinationAccountName: selectedBeneficiary.value.accountName,
                          destinationAccountNumber: selectedBeneficiary.value.accountNumber,
                          destinationCountryCode: transferState.destinationCountry?.code,
                          destinationCurrency: transferState.destinationCurrency?.code,
                          sourceAccountNumber: fromBalance.value.accountNumber,
                          sourceCurrency: transferState.sourceCurrency?.code,
                          serviceTypeCode: "ST000015",
                          amount: double.parse(sourceAmount.value.replaceAll(',', '')),
                          description: '',
                        ),
                      );
                }
              },
            )
                .animate()
                .fadeIn(begin: 0, delay: 500.ms)
                // .then(delay: 200.ms)
                .slideY(begin: .1, end: 0),
          ],
        ),
      ),
    );
  }
}
