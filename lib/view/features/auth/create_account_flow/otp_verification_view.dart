import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:remittance_mobile/view/features/auth/widgets/auth_title.dart';
import 'package:remittance_mobile/view/theme/app_theme.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/back_button.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/richtext_widget.dart';

class OTPVerificationView extends ConsumerStatefulWidget {
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
                  title: 'OTP Verification',
                  subtitle: 'Enter the 6 digit code sent to +1 **** **** 7376'),
              32.0.height,
              Center(
                child: Pinput(
                  length: 6,
                  obscureText: true,
                  defaultPinTheme: defaultPinInputTheme,
                  focusedPinTheme: focusedPinInputTheme,
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          height: 100.h,
          children: [
            const RichTextWidget(
              text: "Didn't receive a code? ",
              hyperlink: 'Send to Email',
              onTap: null,
            ),
            12.0.height,
            MainButton(
              //isLoading: true,
              text: 'Continue',
              onPressed: () {
                widget.pressed();
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
