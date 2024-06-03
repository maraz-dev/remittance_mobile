import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/requests/security_questions_req.dart';
import 'package:remittance_mobile/data/models/requests/set_security_question_req.dart';
import 'package:remittance_mobile/data/models/responses/security_question.dart';
import 'package:remittance_mobile/view/features/auth/login_view.dart';
import 'package:remittance_mobile/view/features/auth/vm/auth_providers.dart';
import 'package:remittance_mobile/view/features/auth/vm/security_questions_vm/set_security_question_vm.dart';
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

class SetSecurityQuestionView extends ConsumerStatefulWidget {
  static String path = 'set-security-question-view';
  const SetSecurityQuestionView({super.key});

  @override
  ConsumerState<SetSecurityQuestionView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<SetSecurityQuestionView> {
  // Global Key Form Key
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<State> _questionOneKey = GlobalKey();
  final GlobalKey<State> _questionTwoKey = GlobalKey();

  // Controllers
  final TextEditingController _questionOne = TextEditingController();
  final TextEditingController _questionTwo = TextEditingController();
  final TextEditingController _answerOne = TextEditingController();
  final TextEditingController _answerTwo = TextEditingController();
  final TextEditingController _pin = TextEditingController();

  // Variable to hold the Selected Question
  SecurityQuestionItem _selectedQuestion = SecurityQuestionItem();
  SecurityQuestionItem _selectedQuestionTwo = SecurityQuestionItem();

  @override
  void dispose() {
    _questionOne.dispose();
    _questionTwo.dispose();
    _answerOne.dispose();
    _answerTwo.dispose();
    _pin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getSecurityQuestion = ref.watch(getSecurityQuestionsProvider);
    final setQuestionLoading = ref.watch(setSecurityQuestionProvider);

    // Validate Security Question Provider
    ref.listen(setSecurityQuestionProvider, (_, next) {
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
                title: 'Security Questions Created',
                subtitle:
                    'Your access request is verified and your ErrandPay account is now active. Call 08188880951 if you didn’t request this change.',
              ),
              40.0.height,
              MainButton(
                text: 'Back to Login',
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

    return AbsorbPointer(
      absorbing: getSecurityQuestion.isLoading || setQuestionLoading.isLoading,
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
                    title: 'Security Question',
                    subtitle: 'Setup your Security Questions and Answers',
                  ),
                  32.0.height,
                  getSecurityQuestion.maybeWhen(
                    orElse: () => input.TextInput(
                      header: 'Security Question 1',
                      controller: _questionOne,
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
                      header: 'Security Question 1',
                      controller: _questionOne,
                      hint: error.toString(),
                      inputType: TextInputType.text,
                      validator: validateGeneric,
                      readOnly: true,
                    ),
                    data: (data) {
                      List<String> itemList =
                          data.map((item) => item.question ?? '').toList();
                      return input.TextInput(
                        key: _questionOneKey,
                        header: 'Security Question 1',
                        controller: _questionOne,
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
                              _questionOne.text = newValue ?? '';
                              _selectedQuestion = data.elementAt(
                                data.indexWhere(
                                    (element) => element.question == newValue),
                              );
                            },
                            key: _questionOneKey,
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
                    controller: _answerOne,
                    hint: '********',
                    inputType: TextInputType.visiblePassword,
                    validator: validateGeneric,
                  ),
                  16.0.height,
                  getSecurityQuestion.maybeWhen(
                    orElse: () => input.TextInput(
                      header: 'Security Question 2',
                      controller: _questionTwo,
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
                      header: 'Security Question 2',
                      controller: _questionTwo,
                      hint: error.toString(),
                      inputType: TextInputType.text,
                      validator: validateGeneric,
                      readOnly: true,
                    ),
                    data: (data) {
                      List<String> itemList =
                          data.map((item) => item.question ?? '').toList();
                      return input.TextInput(
                        key: _questionTwoKey,
                        header: 'Security Question 2',
                        controller: _questionTwo,
                        hint: "Select Security Question",
                        inputType: TextInputType.text,
                        validator: validateGeneric,
                        readOnly: true,
                        onPressed: () {
                          platformSpecificDropdown(
                            context: context,
                            items: itemList,
                            value: _selectedQuestionTwo.id ?? '',
                            onChanged: (newValue) {
                              _questionTwo.text = newValue ?? '';
                              _selectedQuestionTwo = data.elementAt(
                                data.indexWhere(
                                    (element) => element.question == newValue),
                              );
                            },
                            key: _questionTwoKey,
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
                    controller: _answerTwo,
                    hint: '********',
                    inputType: TextInputType.visiblePassword,
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
              isLoading: setQuestionLoading.isLoading,
              text: 'Done',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ref
                      .read(setSecurityQuestionProvider.notifier)
                      .setSecurityQuestionMethod(SetSecurityQuestionReq(
                        securityQuestions: [
                          SecurityQuestionReq(
                            questionId: _selectedQuestion.id,
                            answer: _answerOne.text.trim(),
                          ),
                          SecurityQuestionReq(
                            questionId: _selectedQuestionTwo.id,
                            answer: _answerTwo.text.trim(),
                          ),
                        ],
                      ));
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
