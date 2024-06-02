import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/requests/create_password_req.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/create_transaction_pin.dart';
import 'package:remittance_mobile/view/features/auth/vm/create_account_vm/create_password_vm.dart';
import 'package:remittance_mobile/view/features/auth/widgets/auth_title.dart';
import 'package:remittance_mobile/view/features/auth/widgets/bottomsheet_title.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
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

class _CreateAccountPasswordFormViewState
    extends ConsumerState<CreateAccountPasswordFormView> {
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
                subtitle: 'Welcome to BorderPal. Let’s shake the world!',
              ),
              40.0.height,
              MainButton(
                text: 'Create Transaction PIN',
                onPressed: () {
                  context.pop();
                  AppBottomSheet.showBottomSheet(
                    context,
                    isDismissible: false,
                    widget: const CreateTransactionPINSheet(),
                  );
                },
              ),
              12.0.height
            ],
          ),
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
                              return 'Field cannot be empty';
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
        ),
        bottomNavigationBar: BottomNavBarWidget(
          children: [
            MainButton(
              isLoading: loading.isLoading,
              text: 'Continue',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ref
                      .read(createPasswordProvider.notifier)
                      .createPasswordMethod(CreatePasswordReq(
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
