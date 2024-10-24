import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/requests/send_money_to_bank_req.dart';
import 'package:remittance_mobile/view/features/home/account-view/exchange/exchange_transaction_detail.dart';
import 'package:remittance_mobile/view/features/home/widgets/validate_pin_sheet.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_how_much_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_to_who_view.dart';
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
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class SendMoneyDetailsView extends ConsumerStatefulWidget {
  static const path = 'send-money-detail-view';
  const SendMoneyDetailsView({super.key});

  @override
  ConsumerState<SendMoneyDetailsView> createState() => _SendMoneyDetailsViewState();
}

class _SendMoneyDetailsViewState extends ConsumerState<SendMoneyDetailsView> {
  @override
  Widget build(BuildContext context) {
    final sendMoneyLoading = ref.watch(sendToBankProvider).isLoading;

    ref.listen(sendToBankProvider, (_, next) {
      if (next is AsyncData) {
        AppBottomSheet.showBottomSheet(
          context,
          isDismissible: true,
          enableDrag: false,
          widget: SuccessTranxSheet(
            amount: 500.amountWithCurrency(sourceCurrency.value.code ?? ''),
            accountDetails:
                '${selectedBeneficiary.value.accountNumber} ${selectedBeneficiary.value.bankName}',
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
        body: ScaffoldBody(
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
                        description: '1000 ${sourceCurrency.value.code}',
                      ),
                      16.0.height,
                      TrxItems(
                        title: 'At (rate)',
                        description:
                            '1 ${destinationCurrency.value.code} - 1500 ${sourceCurrency.value.code}',
                      ),
                      16.0.height,
                      TrxItems(
                        title: 'Bank Transfer fees',
                        description: '50 ${sourceCurrency.value.code}',
                      ),
                      16.0.height,
                      TrxItems(
                        title: 'Recipient receives',
                        description: '1,500,000 ${destinationCurrency.value.code}',
                      ),
                      16.0.height,
                      TrxItems(
                        title: 'You Pay',
                        description: '1,500,000 ${sourceCurrency.value.code}',
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
                  title: selectedBeneficiary.value.accountName ?? 'John Doe',
                  subtitle:
                      '${selectedBeneficiary.value.accountNumber} - ${selectedBeneficiary.value.bankName}',
                ),
                24.0.height,
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          children: [
            MainButton(
              text: 'Send',
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
