import 'package:flutter/material.dart';
import 'package:remittance_mobile/data/models/responses/fund_with_bank_transfer_dto.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/payment_method_sheet/bank_transfer_sheet.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/payment_method_sheet/debit_card_sheet.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/payment_method_sheet/platform_pay_sheet.dart';
import 'package:remittance_mobile/view/features/home/widgets/payment_method_card.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class ExchangeReceiveMoneyOptionsView extends StatelessWidget {
  static const path = 'exchange-receive-money-options-view';

  const ExchangeReceiveMoneyOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Exchange'),
      body: ScaffoldBody(
          body: Column(
        children: [
          20.0.height,
          Text(
            'Choose how you want to receive your money',
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
                      child: exchangeMethods[index],
                    );
                  },
                  separatorBuilder: (context, index) => 24.0.height,
                  itemCount: exchangeMethods.length,
                ),
                16.0.height,
              ],
            ),
          )
        ],
      )),
    );
  }
}

void methodBottomSheet(int index, BuildContext context) {
  switch (index) {
    case 0:
      AppBottomSheet.showBottomSheet(
        context,
        widget: const DebitCardSheet(),
      );
    case 1:
      AppBottomSheet.showBottomSheet(
        context,
        widget: BankTransferSheet(
          transferCountry: TransferCountry.ngn,
          ngnTransferDetails: FundWithBankTransferDto(),
        ),
      );
    case 2:
      AppBottomSheet.showBottomSheet(
        context,
        widget: const PlatformPaySheet(),
      );
  }
}

List<PaymentMethodCard> exchangeMethods = [
  const PaymentMethodCard(
    methodImage: AppImages.card,
    methodName: 'Cash Pick Up',
    methodDescription: 'Choose from a list of verified pick up locations to get the cash.',
  ),
  const PaymentMethodCard(
    methodImage: AppImages.accountDetails,
    methodName: 'Bank Transfer',
    methodDescription: 'Provide details of your account to receive money from the seller.',
  ),
  const PaymentMethodCard(
    methodImage: AppImages.homeIcon,
    methodName: 'Home Delivery',
    methodDescription: 'Get your money delivered to you at home.',
  ),
];
