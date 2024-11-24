import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';
import 'package:remittance_mobile/data/models/requests/initiate_forgot_password_req.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/create_account_form_view.dart';
import 'package:remittance_mobile/view/features/auth/forgot-password/forgot_password_otp_form.dart';
import 'package:remittance_mobile/view/features/auth/vm/forgot_password_vm/initiate_forgot_pass_vm.dart';
import 'package:remittance_mobile/view/features/auth/widgets/auth_title.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart' as input;
import 'package:remittance_mobile/view/utils/snackbar.dart';
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
  void initState() {
    super.initState();
    _email.text = SharedPrefManager.email;
  }

  @override
  void dispose() {
    _email.dispose();
    _pin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(initiateForgotPasswordProvider);
    ref.listen(initiateForgotPasswordProvider, (_, next) {
      if (next is AsyncData<bool>) {
        successfulCreatedEmail.value = _email.text;
        context.pushNamed(ForgotPasswordOtpForm.path);
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });
    return AbsorbPointer(
      absorbing: loading.isLoading,
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
                    title: 'Forgot Password',
                    subtitle: 'Confirm your Email Address Below.',
                  ),
                  32.0.height,
                  input.TextInput(
                    header: 'Email Address',
                    controller: _email,
                    hint: "Enter Email Address",
                    inputType: TextInputType.emailAddress,
                    validator: validateEmail,
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
              isLoading: loading.isLoading,
              text: 'Continue',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ref.read(initiateForgotPasswordProvider.notifier).initiateForgotPasswordMethod(
                        InitiateForgotPassReq(
                          email: _email.text.trim(),
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
