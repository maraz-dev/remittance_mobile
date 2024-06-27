import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/features/profile/more/help_and_support_view.dart';
import 'package:remittance_mobile/view/features/profile/more/privacy_policy_view.dart';
import 'package:remittance_mobile/view/features/profile/more/terms_and_conditions_view.dart';
import 'package:remittance_mobile/view/features/profile/personal-info/account_statements_view.dart';
import 'package:remittance_mobile/view/features/profile/personal-info/personal_details_view.dart';
import 'package:remittance_mobile/view/features/profile/security/change_password_view.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';

class ProfileOption {
  final String? text;
  final String? image;
  final Widget? switchButton;
  final Function()? onPressed;
  final dynamic optionPath;
  final Color? color;

  ProfileOption({
    this.text,
    this.image,
    this.switchButton,
    this.onPressed,
    this.optionPath,
    this.color = AppColors.kGrey700,
  });
}

// Personal Info Items
List<ProfileOption> profilePersonalInfoItems = [
  ProfileOption(
    image: AppImages.user,
    text: 'Personal Details',
    optionPath: PersonalDetailsView.path,
  ),
  ProfileOption(image: AppImages.accountLimit, text: 'Account Limits'),
  ProfileOption(
    image: AppImages.documentText,
    text: 'Account Statements',
    optionPath: AccountStatementView.path,
  ),
];

// Security Items
List profileSecurityItems = [
  ProfileOption(
    image: AppImages.lock,
    text: 'Change Password',
    optionPath: ChangePasswordView.path,
  ),
  ProfileOption(
    image: AppImages.shieldSecurity,
    text: 'Change PIN',
  ),
  ProfileOption(
    image: AppImages.smsNotification,
    text: 'SMS Notifications',
  ),
  ProfileOption(
    image: AppImages.directNotification,
    text: 'In-app Notifications',
  ),
  ProfileOption(
    image: AppImages.fingerScan,
    text: 'Biometrics',
  ),
];

// More Items
List profileMoreItems = [
  ProfileOption(
    image: AppImages.document,
    text: 'Privacy Policy',
    optionPath: PrivacyPolicyView.path,
  ),
  ProfileOption(
    image: AppImages.termsAndCondition,
    text: 'Terms and Conditions',
    optionPath: TermsAndConditionsView.path,
  ),
  ProfileOption(
    image: AppImages.headphone,
    text: 'Help and Support',
    optionPath: HelpAndSupportView.path,
  ),
  ProfileOption(
      image: AppImages.logout, text: 'Log Out', color: AppColors.kErrorColor),
];
