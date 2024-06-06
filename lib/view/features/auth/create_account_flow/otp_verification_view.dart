import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:remittance_mobile/data/models/requests/verify_phone_number_req.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/choose_country_view.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/create_account_form_view.dart';
import 'package:remittance_mobile/view/features/auth/vm/create_account_vm/verify_phone_number_vm.dart';
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

class OTPVerificationView extends ConsumerStatefulWidget {
  static String path = 'otp-verification-view';

  final VoidCallback pressed;
  const OTPVerificationView({
    super.key,
    required this.pressed,
  });

  @override
  ConsumerState<OTPVerificationView> createState() =>
      _OTPVerificationViewState();
}

class _OTPVerificationViewState extends ConsumerState<OTPVerificationView> {
  // Key to Hold the state of the Form
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Text Editing Controllers
  final TextEditingController _otp = TextEditingController();

  @override
  void dispose() {
    _otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(verifyPhoneNumberProvider);

    // Endpoint State
    ref.listen(verifyPhoneNumberProvider, (_, next) {
      if (next is AsyncData<String>) {
        widget.pressed();
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
                const AuthTitle(title: 'OTP Verification'),
                RichTextWidget(
                  text: 'Enter the 6 digit code sent to ',
                  hyperlink:
                      '+${selectedCountry.value.phoneCode}${successfulCreatedPhoneNo.value.mask()}',
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
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          children: [
            const RichTextWidget(
              text: "Didn't receive a code? ",
              hyperlink: 'Send to Email',
              onTap: null,
            ),
            12.0.height,
            MainButton(
              isLoading: loading.isLoading,
              text: 'Continue',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ref
                      .read(verifyPhoneNumberProvider.notifier)
                      .verifyPhoneNumberMethod(
                          VerifyPhoneNumberReq(otp: _otp.text));
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
