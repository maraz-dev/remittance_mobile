import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:remittance_mobile/view/features/auth/widgets/auth_title.dart';
import 'package:remittance_mobile/view/features/auth/widgets/bottomsheet_title.dart';
import 'package:remittance_mobile/view/theme/app_theme.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/back_button.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/password_validator.dart';

class CreateAccountPasswordFormView extends ConsumerStatefulWidget {
  final VoidCallback pressed;
  const CreateAccountPasswordFormView({
    super.key,
    required this.pressed,
  });

  @override
  ConsumerState<CreateAccountPasswordFormView> createState() =>
      _CreateAccountPasswordFormViewState();
}

class _CreateAccountPasswordFormViewState
    extends ConsumerState<CreateAccountPasswordFormView> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  void dispose() {
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.0.height,
              const BackArrowButton(),
              18.0.height,
              const AuthTitle(
                  title: 'Create Password',
                  subtitle: 'Create a password for your account.'),
              32.0.height,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      PasswordInput(
                        header: 'Password',
                        controller: _password,
                        hint: '********',
                        inputType: TextInputType.visiblePassword,
                        validator: validatePassword,
                      ),
                      24.0.height,
                      PasswordInput(
                        header: 'Confirm Password',
                        controller: _confirmPassword,
                        hint: '********',
                        inputType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password field cannot be empty';
                          } else if (value != _password.text) {
                            return "Password doesn't match";
                          }
                          return null;
                        },
                      ),
                      12.0.height,
                      PasswordValidator(controller: _password)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          children: [
            MainButton(
              //isLoading: true,
              text: 'Continue',
              onPressed: () {
                AppBottomSheet.showBottomSheet(
                  context,
                  isDismissible: false,
                  widget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(AppImages.accountCreated),
                      16.0.height,
                      const BottomSheetTitle(
                        title: 'Account Created',
                        subtitle:
                            'Welcome to BorderPal. Let’s shake the world!',
                      ),
                      40.0.height,
                      MainButton(
                        text: 'Create Transaction PIN',
                        onPressed: () {
                          context.pop();
                          AppBottomSheet.showBottomSheet(
                            context,
                            isDismissible: false,
                            widget: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(AppImages.security),
                                16.0.height,
                                const BottomSheetTitle(
                                  title: 'Create Transaction PIN',
                                  subtitle:
                                      'Enter your desired Transaction PIN',
                                ),
                                24.0.height,
                                Center(
                                  child: Pinput(
                                    length: 4,
                                    obscureText: true,
                                    defaultPinTheme: defaultPinInputTheme
                                        .copyWith(height: 70.h, width: 70.w),
                                    focusedPinTheme: focusedPinInputTheme
                                        .copyWith(height: 70.h, width: 70.w),
                                  ),
                                ),
                                40.0.height,
                                MainButton(
                                  text: 'Create PIN',
                                  onPressed: () {
                                    context.pop();
                                    AppBottomSheet.showBottomSheet(
                                      context,
                                      isDismissible: false,
                                      widget: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(AppImages.success),
                                          16.0.height,
                                          const BottomSheetTitle(
                                            title: 'Transaction PIN Created',
                                            subtitle:
                                                'Great job! You have successfully created your Transaction PIN',
                                          ),
                                          40.0.height,
                                          MainButton(
                                            text: 'Start Transacting',
                                            onPressed: () {},
                                          ),
                                          30.0.height
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                30.0.height
                              ],
                            ),
                          );
                        },
                      ),
                      30.0.height
                    ],
                  ),
                );
              },
            )
                .animate()
                .fadeIn(begin: 0, delay: 1000.ms)
                // .then(delay: 200.ms)
                .slideY(begin: .1, end: 0),
          ],
        ),
      ),
    );
  }
}