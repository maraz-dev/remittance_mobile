import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:remittance_mobile/data/models/requests/forgot_pass_verify_otp.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/create_account_form_view.dart';
import 'package:remittance_mobile/view/features/auth/forgot-password/reset_password_view.dart';
import 'package:remittance_mobile/view/features/auth/vm/forgot_password_vm/forgot_pass_otp_vm.dart';
import 'package:remittance_mobile/view/features/auth/widgets/auth_title.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/theme/app_theme.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/back_button.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/richtext_widget.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ForgotPasswordOtpForm extends ConsumerStatefulWidget {
  static String path = 'forgot-password-otp-form';
  const ForgotPasswordOtpForm({super.key});

  @override
  ConsumerState<ForgotPasswordOtpForm> createState() => _ForgotPasswordOtpFormState();
}

class _ForgotPasswordOtpFormState extends ConsumerState<ForgotPasswordOtpForm> {
// Key to Hold the state of the Form
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Text Editing Controllers
  final TextEditingController _otp = TextEditingController();

  // Stopwatch Timer
  final StopWatchTimer _timer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromSecond(60),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _timer.onStartTimer();
      },
    );
  }

  @override
  void dispose() {
    _otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(verifyForgotPassOTPProvider);

    // Endpoint State
    ref.listen(verifyForgotPassOTPProvider, (_, next) {
      if (next is AsyncData<String>) {
        context.pushNamed(ResetPasswordView.path);
        // _timer.onResetTimer();
        //   _timer.onStartTimer();
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });
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
              const AuthTitle(title: 'OTP Verification'),
              RichTextWidget(
                text: 'Enter the 6 digit code sent to ',
                hyperlink: successfulCreatedEmail.value,
                hyperlinkColor: AppColors.kGrey700,
              ),
              32.0.height,
              Center(
                child: Pinput(
                  controller: _otp,
                  length: 6,
                  obscureText: true,
                  defaultPinTheme: defaultPinInputTheme,
                  focusedPinTheme: focusedPinInputTheme,
                  validator: validateGeneric,
                ),
              ),
              16.0.height,
              StreamBuilder(
                stream: _timer.secondTime,
                initialData: _timer.secondTime.value,
                builder: (context, snap) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (snap.data == 0) ...[
                        RichTextWidget(
                          text: "Didn't receive a code? ",
                          hyperlink: 'Resend Code',
                          onTap: () {
                            //ref.read(resendOtpViaEmailProvider.notifier).resendOtpEmailMethod();
                          },
                        ),
                      ] else ...[
                        RichTextWidget(
                          text: "Resend OTP in ",
                          hyperlink: '${snap.data}s',
                          hyperlinkColor: AppColors.kGrey700,
                          onTap: () {
                            //ref.read(resendOtpViaEmailProvider.notifier).resendOtpEmailMethod();
                          },
                        ),
                        5.0.height,
                      ],
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        children: [
          MainButton(
            isLoading: loading.isLoading,
            text: 'Continue',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ref
                    .read(verifyForgotPassOTPProvider.notifier)
                    .verifyForgotPassOTPMethod(ForgotPasswordOtpReq(
                      email: successfulCreatedEmail.value,
                      otp: _otp.text,
                    ));
              }
            },
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
