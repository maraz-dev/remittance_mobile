import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pay_mobile/view/features/auth/login_screen.dart';
import 'package:smart_pay_mobile/view/features/auth/sign_up_email_screen.dart';
import 'package:smart_pay_mobile/view/theme/app_colors.dart';

class BottomWidget extends StatelessWidget {
  final bool isSignIn;
  const BottomWidget({
    super.key,
    required this.isSignIn,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RichText(
      text: TextSpan(
        text:
            isSignIn ? "Don't have an account? " : "Already have an account? ",
        style: Theme.of(context).textTheme.bodyLarge,
        children: [
          TextSpan(
            text: isSignIn ? "Sign Up" : "Sign In",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold, color: AppColors.kSecondaryColor),
            recognizer: TapGestureRecognizer()
              ..onTap = isSignIn
                  ? () {
                      context.pushNamed(SignUpEmailScreen.path);
                    }
                  : () {
                      context.pushNamed(LoginScreen.path);
                    },
          ),
        ],
      ),
    ));
  }
}
