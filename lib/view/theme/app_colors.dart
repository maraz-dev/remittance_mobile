import 'package:config/config.dart';
import 'package:flutter/material.dart';

abstract class AppColors {
  static const kPrimaryColor = Color(APP_PRIMARY_COLOR);
  static const kSecondaryColorTwo = Color(APP_SECONDARY_COLOR);
  static const kAccentColor = Color(APP_ACCENT_COLOR);
  static const kGreyInput = Color(0xFFEFF1F4);
  static const kGrey50 = Color(0xFFF9FAFB);
  static const kGrey100 = Color(0xFFF2F4F7);
  static const kGrey300 = Color(0xFFD0D5DD);
  static const kGrey200 = Color(0xFFEAECF0);
  static const kGrey500 = Color(0xFF667085);
  static const kGrey700 = Color(0xFF344054);
  static const kGrey800 = Color(0xFF1D2939);

  static const kInactiveColor = Color(0xFF6B7280);
  static const kTextColor = Color(0xFF98A2B3);
  static const kHintColor = Color(0xFF98A2B3);
  static final kCardColor = kPrimaryColor.withOpacity(0.5);
  static const kBrandColor = Color(0xFFF0EEFF);

  static const kBlackColor = Color(0xFF000000);
  static const kWhiteColor = Color(0xFFFFFFFF);
  static const kTealColor100 = Color(0xFFF0F9FF);
  static const kTealColor200 = Color(0xFF026AA2);
  static const kBlueColor500 = Color(0xFF151076);
  static final kPurpleColor = kPrimaryColor.withOpacity(0.2);

  static const kSuccessColor = Color(0xFF039855);
  static const kSuccessColor50 = Color(0xFFD1FADF);
  static const kLightSuccessColor = Color(0xFFECFDF3);
  static const kWarningColor = Color(0xFFDC6803);
  static const kWarningColor50 = Color(0xFFFFFAEB);
  static const kWarningColor100 = Color(0xFFFEF0C7);
  static const kWarningColor500 = Color(0xFFF79009);
  static const kWarningColor700 = Color(0xFFB54708);

  static const kErrorColor = Color(0xFFD92D20);
  static const kTextBorderColor = Color(0xFFF9F8FF);
  static final kBoxShadowColor = const Color(0xFF101828).withOpacity(0.1);
}
