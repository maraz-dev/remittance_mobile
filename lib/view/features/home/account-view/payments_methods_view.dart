import 'package:flutter/material.dart';
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
                      onTap: () {},
                      child: paymentMethods[index],
                    );
                  },
                  separatorBuilder: (context, index) => 24.0.height,
                  itemCount: paymentMethods.length,
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
          widget: Container(),
        );
      case 1:
    }
  }
}
