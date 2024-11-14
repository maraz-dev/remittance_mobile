import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/requests/checkout_req.dart';
import 'package:remittance_mobile/data/models/requests/inititiate_ussd_funding_req.dart';
import 'package:remittance_mobile/data/models/responses/ussd_bank_model.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/add_money_view.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/payment_method_sheet/platform_pay_sheet.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/payment_method_sheet/ussd_bank_sheet.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/payment_method_sheet/ussd_sheet.dart';
import 'package:remittance_mobile/view/features/home/currency_account_view.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/account_providers.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/checkout_vm.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/fund_with_ussd_vm.dart';
import 'package:remittance_mobile/view/features/home/widgets/payment_method_card.dart';
import 'package:remittance_mobile/view/features/webview/app_webview.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/overlay_animation.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class PaymentMethodView extends ConsumerStatefulWidget {
  static const path = 'payment-method-view';
  const PaymentMethodView({super.key});

  @override
  ConsumerState<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends ConsumerState<PaymentMethodView> {
  UssdBanksDto? selectedResult;
  @override
  Widget build(BuildContext context) {
    final checkoutloading = ref.watch(fundWithCheckoutProvider).isLoading;
    final ussdLoading = ref.watch(fundWithUssdProvider).isLoading;
    final fundingOptions =
        ref.watch(getFundingOptionsProvider(accountInfo.value.accountNumber ?? ""));

    ref.listen(fundWithUssdProvider, (_, next) {
      if (next is AsyncData) {
        AppBottomSheet.showBottomSheet(
          context,
          enableDrag: false,
          isDismissible: false,
          widget: UssdFundSheet(
            bank: selectedResult?.bank ?? "",
            amount: next.value?.amount ?? 0.0,
            ussdCode: next.value?.note ?? "",
            flwTransactionId: next.value?.flwTransactionId ?? 0,
          ),
        );
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });

    ref.listen(fundWithCheckoutProvider, (_, next) {
      if (next is AsyncData) {
        //flwTransactionId.value = next.value?.
        context.pushNamed(
          WebviewScreen.path,
          pathParameters: {
            "url": next.value?.link ?? "",
            "routeName": "checkout",
          },
        );
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });
    return Scaffold(
      appBar: innerAppBar(title: 'Add Money'),
      body: OverlayLoadingIndicator(
        isLoading: checkoutloading || ussdLoading,
        child: ScaffoldBody(
            body: Column(
          children: [
            16.0.height,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.kWhiteColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.0.height,
                  const SectionHeader(text: 'Payment Methods'),
                  20.0.height,
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          methodBottomSheet(index, context, ref);
                        },
                        child: paymentMethods[index],
                      );
                    },
                    separatorBuilder: (context, index) => 24.0.height,
                    itemCount: 2,
                  ),
                  20.0.height,
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  methodBottomSheet(int index, BuildContext context, WidgetRef ref) {
    handleReq() async {
      selectedResult = await AppBottomSheet.showBottomSheet(
        context,
        widget: const UssdBanksSheet(vendorCode: 'FLW'),
      );
      if (selectedResult == null) return;

      ref.read(fundWithUssdProvider.notifier).fundWithUssdMethod(
            InitiateUssdFundingReq(
              bankCode: selectedResult?.code,
              amount: double.parse(addMoneyAmount.value.replaceAll(',', '')),
              charge: 0,
            ),
          );
    }

    switch (index) {
      case 0:
        ref.read(fundWithCheckoutProvider.notifier).fundWithCheckoutMethod(
              CheckoutReq(
                amount: double.parse(addMoneyAmount.value.replaceAll(',', '')),
                currency: accountInfo.value.currencyCode,
                charge: 0,
                accountNumber: accountInfo.value.accountNumber,
                redirectUrl: "https://borderpal.co",
              ),
            );
      // context.pushNamed(DebitCardSheet.path);
      // AppBottomSheet.showBottomSheet(
      //   context,
      //   widget: const DebitCardSheet(),
      // );
      case 1:
        handleReq();
      case 2:
        AppBottomSheet.showBottomSheet(
          context,
          widget: const PlatformPaySheet(),
        );
    }
  }
}
