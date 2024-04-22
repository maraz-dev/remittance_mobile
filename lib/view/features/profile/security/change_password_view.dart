import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/password_validator.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class ChangePasswordView extends StatefulWidget {
  static String path = 'change-password-view';
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();

  @override
  void dispose() {
    _oldPassword.dispose();
    _newPassword.dispose();
    _confirmNewPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Change Password'),
      body: ScaffoldBody(
        body: SingleChildScrollView(
          child: Column(
            children: [
              24.0.height,

              /// Old Password
              PasswordInput(
                header: 'Old Password',
                controller: _oldPassword,
                hint: '********',
                inputType: TextInputType.visiblePassword,
                validator: validatePassword,
              ),
              16.0.height,

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
                header: 'Confirn New Password',
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
            onPressed: () {},
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
