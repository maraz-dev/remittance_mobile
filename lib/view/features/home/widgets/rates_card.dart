import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class RatesCard extends StatelessWidget {
  const RatesCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.kBorderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: AppColors.kCountryDropDownColor,
            ),
            child: Row(
              children: [
                Image.asset(
                  AppImages.ng,
                  width: 20.w,
                  height: 20.h,
                ),
                5.0.width,
                InkWell(
                  child: SvgPicture.asset(AppImages.arrowDown),
                )
              ],
            ),
          ),
          12.0.width,
          Text(
            "Today's Rate",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.kBlueColor, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                1.amountWithCurrency('usd'),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.kSecondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              5.0.width,
              SvgPicture.asset(AppImages.swap),
              5.0.width,
              Text(
                1500.00.amountWithCurrency('ngn'),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.kSecondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
