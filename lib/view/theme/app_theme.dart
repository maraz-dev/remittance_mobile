import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_pay_mobile/view/theme/app_colors.dart';

ThemeData themeData() {
  return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: AppColors.kWhiteColor,
      fontFamily: 'SFPro',
      textTheme: textTheme(),
      inputDecorationTheme: inputDecorationTheme());
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder focusInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: AppColors.kSecondaryColorTwo, width: 2),
  );
  OutlineInputBorder defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: Colors.transparent, width: 1),
  );
  OutlineInputBorder errorInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: AppColors.kErrorColor, width: 1),
  );
  return InputDecorationTheme(
    contentPadding: const EdgeInsets.all(16),
    enabledBorder: defaultInputBorder,
    focusedBorder: focusInputBorder,
    errorBorder: errorInputBorder,
    border: defaultInputBorder,
    fillColor: AppColors.kTextfieldColor,
    filled: true,
    suffixIconColor: AppColors.kInactiveColor,
  );
}

TextTheme textTheme() {
  return TextTheme(
    displayLarge: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.2,
      color: AppColors.kPrimaryColor,
    ),
    displayMedium: TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.4,
      color: AppColors.kPrimaryColor,
    ),
    displaySmall: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      color: AppColors.kPrimaryColor,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.3,
      color: AppColors.kTextColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.3,
      color: AppColors.kTextColor,
    ),
    bodySmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.3,
      color: AppColors.kTextColor,
    ),
  );
}

// AppBarTheme appBarTheme() {
//   return const AppBarTheme(
//     centerTitle: true,
//     elevation: 0,
//     color: Colors.transparent,
//     iconTheme: IconThemeData(
//       color: kWhiteColor,
//     ),
//   );