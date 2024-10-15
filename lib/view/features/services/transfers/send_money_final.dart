import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/payment_method_sheet/platform_pay_sheet.dart';
import 'package:remittance_mobile/view/features/home/account-view/exchange/exchange_method_sheet/bank_deposit_sheet.dart';
import 'package:remittance_mobile/view/features/home/account-view/exchange/exchange_method_sheet/cash_drop_off_sheet.dart';
import 'package:remittance_mobile/view/features/home/widgets/payment_method_card.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class SendMoneyFinalView extends StatelessWidget {
  static const path = 'send-money-final-view';
  const SendMoneyFinalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Send Money'),
      body: ScaffoldBody(
          body: Column(
        children: [
          20.0.height,
          Text(
            'Send Money From?',
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          24.0.height,
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
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        methodBottomSheet(index, context);
                      },
                      child: sendMethods[index],
                    );
                  },
                  separatorBuilder: (context, index) => 24.0.height,
                  itemCount: sendMethods.length,
                ),
                16.0.height,
              ],
            ),
          )
        ],
      )),
    );
  }

  void methodBottomSheet(int index, BuildContext context) {
    switch (index) {
      case 0:
        AppBottomSheet.showBottomSheet(
          context,
          widget: const CashDropOffSheet(),
        );
      case 1:
        AppBottomSheet.showBottomSheet(
          context,
          widget: const BankDepositSheet(),
        );
      case 2:
        AppBottomSheet.showBottomSheet(
          context,
          widget: const PlatformPaySheet(),
        );
    }
  }
}

List<PaymentMethodCard> sendMethods = [
  const PaymentMethodCard(
    methodImage: AppImages.accountDetails,
    methodName: 'Bank Transfer',
    methodDescription:
        'Choose a preferred bank to deposit the money into the sellers account.',
  ),
  const PaymentMethodCard(
    methodImage: AppImages.wallet,
    methodName: 'Balance (BorderPay)',
    methodDescription:
        'Use your main balance, the money will be debited directly from this account.',
  ),
];
