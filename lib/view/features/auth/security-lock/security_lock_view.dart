import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/requests/security_questions_req.dart';
import 'package:remittance_mobile/data/models/responses/security_question.dart';
import 'package:remittance_mobile/view/features/auth/login_view.dart';
import 'package:remittance_mobile/view/features/auth/vm/auth_providers.dart';
import 'package:remittance_mobile/view/features/auth/vm/create_account_vm/validate_pin_vm.dart';
import 'package:remittance_mobile/view/features/auth/vm/security_questions_vm/validate_security_question.dart';
import 'package:remittance_mobile/view/features/auth/widgets/auth_title.dart';
import 'package:remittance_mobile/view/features/auth/widgets/bottomsheet_title.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_dropdown.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart' as input;
import 'package:remittance_mobile/view/utils/snackbar.dart';
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

  /// Variable to hold the Selected Question
  SecurityQuestionItem _selectedQuestion = SecurityQuestionItem();

  @override
  void dispose() {
    _question.dispose();
    _answer.dispose();
    _pin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getSecurityQuestion = ref.watch(getSecurityQuestionsProvider);
    final pinLoading = ref.watch(validatePINProvider);
    final validateQuestionLoading = ref.watch(validateSecurityQuestionProvider);

// Validate Security Question Provider
    ref.listen(validateSecurityQuestionProvider, (_, next) {
      if (next is AsyncData<String>) {
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
                  context.pushNamed(LoginScreen.path);
                },
              ),
              16.0.height,
            ],
          ),
        );
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });

    ref.listen(validatePINProvider, (_, next) {
      if (next is AsyncData<String>) {
        ref
            .read(validateSecurityQuestionProvider.notifier)
            .validateSecurityQuestionMethod(SecurityQuestionReq(
              questionId: _selectedQuestion.id,
              answer: _answer.text,
            ));
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });

    return AbsorbPointer(
      absorbing: getSecurityQuestion.isLoading ||
          pinLoading.isLoading ||
          validateQuestionLoading.isLoading,
      child: Scaffold(
        body: ScaffoldBody(
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  32.0.height,
                  const BackArrowButton(),
                  18.0.height,
                  const AuthTitle(
                    title: 'Security Lock',
                    subtitle: 'Enter your Security Question and Answer',
                  ),
                  32.0.height,
                  getSecurityQuestion.maybeWhen(
                    orElse: () => input.TextInput(
                      header: 'Security Question',
                      controller: _question,
                      hint: "Loading...",
                      inputType: TextInputType.text,
                      validator: validateGeneric,
                      readOnly: true,
                      suffixIcon: SvgPicture.asset(
                        AppImages.arrowDown,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    error: (error, stackTrace) => input.TextInput(
                      header: 'Security Question',
                      controller: _question,
                      hint: error.toString(),
                      inputType: TextInputType.text,
                      validator: validateGeneric,
                      readOnly: true,
                    ),
                    data: (data) {
                      List<String> itemList =
                          data.map((item) => item.question ?? '').toList();
                      return input.TextInput(
                        key: _questionKey,
                        header: 'Security Question',
                        controller: _question,
                        hint: "Select Security Question",
                        inputType: TextInputType.text,
                        validator: validateGeneric,
                        readOnly: true,
                        onPressed: () {
                          platformSpecificDropdown(
                            context: context,
                            items: itemList,
                            value: _selectedQuestion.id ?? '',
                            onChanged: (newValue) {
                              _question.text = newValue ?? '';
                              _selectedQuestion = data.elementAt(
                                data.indexWhere(
                                    (element) => element.question == newValue),
                              );
                            },
                            key: _questionKey,
                          );
                        },
                        suffixIcon: SvgPicture.asset(
                          AppImages.arrowDown,
                          fit: BoxFit.scaleDown,
                        ),
                      );
                    },
                  ),
                  16.0.height,
                  input.PasswordInput(
                    header: 'Answer',
                    controller: _answer,
                    hint: '********',
                    inputType: TextInputType.visiblePassword,
                    validator: validateGeneric,
                  ),
                  16.0.height,
                  input.PasswordInput(
                    header: 'Transaction PIN',
                    controller: _pin,
                    hint: '****',
                    maxLength: 4,
                    inputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: validateGeneric,
                  ),
                  24.0.height,
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          children: [
            MainButton(
              isLoading:
                  validateQuestionLoading.isLoading || pinLoading.isLoading,
              text: 'Continue',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ref
                      .read(validatePINProvider.notifier)
                      .validatePINMethod(_pin.text);
                }
              },
            )
                .animate()
                .fadeIn(begin: 0, delay: 1000.ms)
                // .then(delay: 200.ms)
                .slideY(begin: .1, end: 0)
          ],
        ),
      ),
    );
  }
}
