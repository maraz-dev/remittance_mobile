import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/auth/forgot-password/reset_password_view.dart';
import 'package:remittance_mobile/view/features/auth/widgets/auth_title.dart';
import 'package:remittance_mobile/view/features/auth/widgets/bottomsheet_title.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/back_button.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ForgotPasswordView extends ConsumerStatefulWidget {
  static String path = 'forgot-password-view';
  const ForgotPasswordView({super.key});

  @override
  ConsumerState<ForgotPasswordView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<ForgotPasswordView> {
  ///Global Key Form Key
  final GlobalKey<FormState> _formKey = GlobalKey();

  /// Controllers
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pin = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _pin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldBody(
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              32.0.height,
              const BackArrowButton(),
              18.0.height,
              const AuthTitle(
                title: 'Forgot Password',
                subtitle: 'Confirm your Email Address Below.',
              ),
              32.0.height,
              TextInput(
                header: 'Email Address',
                controller: _email,
                hint: "Enter Email Address",
                inputType: TextInputType.emailAddress,
                validator: validateEmail,
              ),
              16.0.height,
              PasswordInput(
                header: 'Transaction PIN',
                controller: _pin,
                hint: '****',
                maxLength: 4,
                inputType: TextInputType.visiblePassword,
                validator: validatePassword,
              ),
              24.0.height,
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        children: [
          MainButton(
            text: 'Reset Password',
            onPressed: () {
              AppBottomSheet.showBottomSheet(
                context,
                isDismissible: false,
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(AppImages.lockIcon),
                    16.0.height,
                    const BottomSheetTitle(
                      title: 'Password Request Sent',
                      subtitle:
                          'A reset password link has been shared to your email address.',
                    ),
                    40.0.height,
                    MainButton(
                      text: 'Check Email',
                      onPressed: () {
                        context.pop();
                        context.pushNamed(ResetPasswordView.path);
                      },
                    ),
                  ],
                ),
              );
            },
          )
              .animate()
              .fadeIn(begin: 0, delay: 1000.ms)
              // .then(delay: 200.ms)
              .slideY(begin: .1, end: 0)
        ],
      ),
    );
  }
}
