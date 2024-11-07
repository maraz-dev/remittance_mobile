import 'package:config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';
import 'package:remittance_mobile/data/models/requests/security_questions_req.dart';
import 'package:remittance_mobile/data/models/responses/security_question_item_model.dart';
import 'package:remittance_mobile/view/features/auth/login_view.dart';
import 'package:remittance_mobile/view/features/auth/vm/auth_providers.dart';
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
  static String path = 'security-lock-view/:email';
  const SecurityLockView({
    super.key,
    required this.email,
  });

  final String email;

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
  bool isPINSet = false;
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
    final initiateValidateDevice = ref.watch(initiateValidateDeviceProvider(widget.email));
    final validateQuestionLoading = ref.watch(validateSecurityQuestionProvider);

// Validate Security Question Provider
    ref.listen(validateSecurityQuestionProvider, (_, next) {
      if (next is AsyncData<String>) {
        SharedPrefManager.email = widget.email;
        AppBottomSheet.showBottomSheet(
          context,
          isDismissible: false,
          enableDrag: false,
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(AppImages.lockIcon),
              16.0.height,
              const BottomSheetTitle(
                title: 'Account Unlocked',
                subtitle:
                    'Your access request is verified and your $APP_NAME account is now active. Call $APP_PARTNER_SUPPORT_NUMBER if you didn’t request this change.',
              ),
              40.0.height,
              MainButton(
                text: 'Back to Login',
                onPressed: () {
                  context.pop();
                  context.goNamed(LoginScreen.path);
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
      absorbing: initiateValidateDevice.isLoading ||
          getSecurityQuestion.isLoading ||
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
                  initiateValidateDevice.maybeWhen(
                    orElse: () => SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 45,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    error: (error, stackTrace) => const Text('An Error Occured, Please Try Again'),
                    data: (data) {
                      setState(() {
                        isPINSet = data.isPinSet ?? false;
                      });
                      return Column(
                        children: [
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
                                animate: false,
                                onPressed: () {
                                  platformSpecificDropdown(
                                    context: context,
                                    items: itemList,
                                    value: _selectedQuestion.id ?? '',
                                    onChanged: (newValue) {
                                      _question.text = newValue ?? '';
                                      _selectedQuestion = data.elementAt(
                                        data.indexWhere((element) => element.question == newValue),
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
                            header: data.isPinSet ?? false
                                ? 'Transaction PIN'
                                : 'Enter the OTP sent to your Email',
                            controller: _pin,
                            hint: '****',
                            maxLength: data.isPinSet ?? false ? 4 : 6,
                            inputType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: validateGeneric,
                          ),
                          24.0.height,
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: initiateValidateDevice.isLoading
            ? null
            : BottomNavBarWidget(
                children: [
                  MainButton(
                    isLoading: validateQuestionLoading.isLoading,
                    text: 'Unlock',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(validateSecurityQuestionProvider.notifier)
                            .validateSecurityQuestionMethod(
                              SecurityQuestionReq(
                                emailAddress: widget.email,
                                questionId: _selectedQuestion.id,
                                answer: _answer.text,
                                isPin: isPINSet,
                                pin: isPINSet ? _pin.text : null,
                                code: isPINSet ? null : _pin.text,
                              ),
                            );
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
