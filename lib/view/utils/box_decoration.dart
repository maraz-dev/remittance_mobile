import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';

BoxDecoration whiteCardDecoration() {
  return BoxDecoration(
    color: AppColors.kWhiteColor,
    borderRadius: BorderRadius.circular(12.r),
    border: Border.all(color: AppColors.kCountryDropDownColor),
  );
}
