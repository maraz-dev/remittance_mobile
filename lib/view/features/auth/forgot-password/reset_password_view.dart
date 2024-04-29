import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/auth/login_screen.dart';
import 'package:remittance_mobile/view/features/auth/widgets/auth_title.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/back_button.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/password_validator.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:remittance_mobile/view/widgets/success_bottomsheet.dart';

class ResetPasswordView extends StatefulWidget {
  static String path = 'reset-password-view';
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();

  @override
  void dispose() {
    _newPassword.dispose();
    _confirmNewPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldBody(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              32.0.height,
              const BackArrowButton(),
              18.0.height,
              const AuthTitle(
                title: 'Reset Password',
                subtitle: 'Enter your New Password.',
              ),
              32.0.height,

              /// New Password
              PasswordInput(
                header: 'New Password',
                controller: _newPassword,
                hint: '********',
                inputType: TextInputType.visiblePassword,
                validator: validatePassword,
              ),
              12.0.height,
              PasswordValidator(controller: _newPassword)
                  .animate()
                  .fadeIn(begin: 0, delay: 700.ms)
                  // .then(delay: 200.ms)
                  .slideY(begin: .1, end: 0),
              16.0.height,

              /// Confirm Password
              PasswordInput(
                header: 'Confirm New Password',
                controller: _confirmNewPassword,
                hint: '********',
                inputType: TextInputType.visiblePassword,
                validator: validatePassword,
              ),
              16.0.height,
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        children: [
          MainButton(
            //isLoading: true,
            text: 'Change Password',
            onPressed: () {
              AppBottomSheet.showBottomSheet(context,
                  widget: SuccessBottomSheet(
                    title: 'Password Reset Successfully',
                    subtitle: 'You’ve successfully reset your password',
                    buttonText: 'Back to Login',
                    action: () =>
                        context.pushReplacementNamed(LoginScreen.path),
                  ));
            },
            color: AppColors.kPrimaryColor.withOpacity(0.3),
          )
              .animate()
              .fadeIn(begin: 0, delay: 1000.ms)
              // .then(delay: 200.ms)
              .slideY(begin: .1, end: 0),
        ],
      ),
    );
  }
}
