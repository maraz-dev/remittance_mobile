import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/features/home/widgets/rates_card.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/current_balance_widget.dart';

class BottomNavBarBalanceInfo extends StatelessWidget {
  final bool? showArrival;
  const BottomNavBarBalanceInfo({
    super.key,
    this.showArrival,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.kGrey50,
        border: Border.all(color: AppColors.kGrey100),
      ),
      child: Column(
        children: [
          const RatesCard(
            showBorder: false,
            color: AppColors.kPinInputColor,
          ),
          Visibility(
            visible: showArrival ?? false,
            child: Column(
              children: [
                10.0.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payment should arrive',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.kGrey700,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      "by Friday 23",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.kGrey700,
                            fontWeight: FontWeight.bold,
                          ),
                    )
                  ],
                ),
              ],
            ),
          ),
          10.0.height,
          const CurrentBalanceWidget()
        ],
      ),
    );
  }
}
