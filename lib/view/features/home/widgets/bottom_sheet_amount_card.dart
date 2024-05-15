import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class BSAmountCard extends StatelessWidget {
  const BSAmountCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
          color: AppColors.kBackgroundColor,
          borderRadius: BorderRadius.circular(8.r)),
      child: Text(
        500.20.amountWithCurrency('usd'),
        style: Theme.of(context)
            .textTheme
            .displayLarge!
            .copyWith(fontSize: 40.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class AdditionalFeeText extends StatelessWidget {
  const AdditionalFeeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Additional Fee:', style: Theme.of(context).textTheme.bodySmall),
        Text(
          2.50.amountWithCurrency('usd'),
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppColors.kSecondaryColor, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
