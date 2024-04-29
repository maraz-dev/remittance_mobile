import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/auth/forgot-password/forgot_password_view.dart';
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

class SecurityLockView extends ConsumerStatefulWidget {
  static String path = 'security-lock-view';
  const SecurityLockView({super.key});

  @override
  ConsumerState<SecurityLockView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<SecurityLockView> {
  ///Global Key Form Key
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<State> _questionKey = GlobalKey();

  /// Controllers
  final TextEditingController _question = TextEditingController();
  final TextEditingController _answer = TextEditingController();
  final TextEditingController _pin = TextEditingController();

  @override
  void dispose() {
    _question.dispose();
    _answer.dispose();
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
                title: 'Security Lock',
                subtitle: 'Enter your security question and answer',
              ),
              32.0.height,
              TextInput(
                key: _questionKey,
                header: 'Security Question 1',
                controller: _question,
                hint: "Select Security Question",
                inputType: TextInputType.emailAddress,
                validator: validateGeneric,
                readOnly: true,
                suffixIcon: SvgPicture.asset(
                  AppImages.arrowDown,
                  fit: BoxFit.scaleDown,
                ),
              ),
              16.0.height,
              PasswordInput(
                header: 'Answer',
                controller: _answer,
                hint: '********',
                inputType: TextInputType.visiblePassword,
                validator: validatePassword,
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
            text: 'Continue',
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
                      title: 'Account Unlocked',
                      subtitle:
                          'Your access request is verified and your ErrandPay account is now active. Call 08188880951 if you didn’t request this change.',
                    ),
                    40.0.height,
                    MainButton(
                      text: 'Back to Dashboard',
                      onPressed: () {
                        context.pop();
                        context.pushNamed(ForgotPasswordView.path);
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
