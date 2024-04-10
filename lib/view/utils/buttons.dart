import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MainButton extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final Color color;
  final Color textColor;
  final bool? isLoading;
  final Function()? onPressed;
  const MainButton({
    super.key,
    required this.text,
    this.isPrimary = true,
    this.color = AppColors.kPrimaryColor,
    this.textColor = AppColors.kWhiteColor,
    required this.onPressed,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
            color: isPrimary ? AppColors.kPrimaryColor : color,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.kBoxShadowColor,
                blurRadius: 2,
                offset: const Offset(0, 1),
              )
            ]),
        child: isLoading ?? false
            ? const SpinKitDualRing(
                color: AppColors.kWhiteColor,
                size: 25,
              )
            : Center(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isPrimary ? AppColors.kWhiteColor : textColor),
                ),
              ),
      ),
    );
  }
}

class SpinKitThreeBounce {
  const SpinKitThreeBounce();
}
