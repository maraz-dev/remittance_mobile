import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';
import 'package:remittance_mobile/data/models/requests/create_password_req.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/create_account_form_view.dart';
import 'package:remittance_mobile/view/features/auth/vm/create_account_vm/create_password_vm.dart';
import 'package:remittance_mobile/view/features/auth/widgets/account_create_success.dart';
import 'package:remittance_mobile/view/features/auth/widgets/auth_title.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/back_button.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/password_validator.dart';

class CreateAccountPasswordFormView extends ConsumerStatefulWidget {
  final VoidCallback pressed;
  static String path = 'create-password-form-view';

  const CreateAccountPasswordFormView({
    super.key,
    required this.pressed,
  });

  @override
  ConsumerState<CreateAccountPasswordFormView> createState() =>
      _CreateAccountPasswordFormViewState();
}

class _CreateAccountPasswordFormViewState extends ConsumerState<CreateAccountPasswordFormView> {
  // Key for Form
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Text Editing Controllers
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
    final loading = ref.watch(createPasswordProvider);

    /// Endpoint State
    ref.listen(createPasswordProvider, (_, next) {
      if (next is AsyncData<String>) {
        SharedPrefManager.email = successfulCreatedEmail.value;
        AppBottomSheet.showBottomSheet(
          context,
          enableDrag: false,
          isDismissible: false,
          widget: const AccountCreateSuccess(),
        );
      }
      if (next is AsyncError) {
        SnackBarDialog.showErrorFlushBarMessage(next.error.toString(), context);
      }
    });
    return AbsorbPointer(
      absorbing: loading.isLoading,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.0.height,
                const BackArrowButton(),
                18.0.height,
                const AuthTitle(
                    title: 'Create Password', subtitle: 'Create a password for your account.'),
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
                              return 'Field cannot be empty';
                            } else if (value != _password.text) {
                              return "Password doesn't Match";
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
        ),
        bottomNavigationBar: BottomNavBarWidget(
          children: [
            MainButton(
              isLoading: loading.isLoading,
              text: 'Continue',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ref.read(createPasswordProvider.notifier).createPasswordMethod(CreatePasswordReq(
                        password: _password.text,
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
      ),
    );
  }
}
