import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/payment_method_sheet/bank_transfer_sheet.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/payment_method_sheet/debit_card_sheet.dart';
import 'package:remittance_mobile/view/features/home/account-view/add-money/payment_method_sheet/platform_pay_sheet.dart';
import 'package:remittance_mobile/view/features/home/widgets/payment_method_card.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:remittance_mobile/view/widgets/section_header.dart';

class PaymentMethodView extends StatelessWidget {
  static const path = 'payment-method-view';
  const PaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Add Money'),
      body: ScaffoldBody(
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
                        methodBottomSheet(index, context);
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
    );
  }

  methodBottomSheet(int index, BuildContext context) {
    switch (index) {
      case 0:
        AppBottomSheet.showBottomSheet(
          context,
          widget: const DebitCardSheet(),
        );
      case 1:
        AppBottomSheet.showBottomSheet(
          context,
          widget: const BankTransferSheet(
            transferCountry: TransferCountry.ngn,
          ),
        );
      case 2:
        AppBottomSheet.showBottomSheet(
          context,
          widget: const PlatformPaySheet(),
        );
    }
  }
}
