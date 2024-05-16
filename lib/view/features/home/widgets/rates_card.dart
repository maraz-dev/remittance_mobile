import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';

class RatesCard extends StatelessWidget {
  final bool? showBorder;
  final Color? color;
  const RatesCard({
    super.key,
    this.showBorder,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ConditionalContainer(
      showContainer: showBorder ?? true,
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
              color: color ?? AppColors.kGrey100,
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
                      color: AppColors.kGrey700,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              5.0.width,
              SvgPicture.asset(AppImages.swap),
              5.0.width,
              Text(
                1500.00.amountWithCurrency('ngn'),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.kGrey700,
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

class ConditionalContainer extends StatelessWidget {
  final bool showContainer;
  final Widget child;
  final BoxDecoration? decoration;

  const ConditionalContainer({
    super.key,
    required this.showContainer,
    required this.child,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return showContainer
        ? Visibility(
            visible: showContainer,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: decoration,
              child: child,
            ),
          )
        : child;
  }
}
