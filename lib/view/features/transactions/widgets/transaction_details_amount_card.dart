import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class TransactionDetailsAmountCard extends StatelessWidget {
  const TransactionDetailsAmountCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.kGrey300),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            12.31.amountWithCurrency('usd'),
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 40.sp, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.kLightSuccessColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              'Successful',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.kSuccessColor, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
