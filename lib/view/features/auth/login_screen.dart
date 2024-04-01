import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay_mobile/view/theme/app_colors.dart';
import 'package:smart_pay_mobile/view/utils/app_images.dart';
import 'package:smart_pay_mobile/view/utils/buttons.dart';
import 'package:smart_pay_mobile/view/utils/extensions.dart';
import 'package:smart_pay_mobile/view/utils/input_fields.dart';
import 'package:smart_pay_mobile/view/utils/validator.dart';
import 'package:smart_pay_mobile/view/widgets/auth_btn.dart';
import 'package:smart_pay_mobile/view/widgets/back_button.dart';
import 'package:smart_pay_mobile/view/widgets/bottom_widget.dart';
import 'package:smart_pay_mobile/view/widgets/scaffold_body.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String path = '/login-screen';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginScreen> {
  ///Global Key Form Key
  final GlobalKey<FormState> _formKey = GlobalKey();

  /// Controllers
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldBody(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BackArrowButton(),
            32.0.height,
            Text(
              'Hi There! 👋',
              style: Theme.of(context).textTheme.displayLarge,
            )
                .animate()
                .fadeIn(begin: 0, delay: 400.ms)
                .slideX(begin: -.1, end: 0),
            8.0.height,
            const Text('Welcome back, Sign in to your account')
                .animate()
                .fadeIn(begin: 0, delay: 400.ms)
                .slideX(begin: -.1, end: 0),
            32.0.height,
            TextInput(
              controller: _email,
              hint: "Email",
              inputType: TextInputType.emailAddress,
              validator: validateEmail,
            )
                .animate()
                .fadeIn(begin: 0, delay: 500.ms)
                .slideY(begin: .5, end: 0),
            16.0.height,
            PasswordInput(
              controller: _password,
              hint: 'Password',
              inputType: TextInputType.visiblePassword,
              validator: validatePassword,
            )
                .animate()
                .fadeIn(begin: 0, delay: 500.ms)
                .slideY(begin: .5, end: 0),
            24.0.height,
            Text(
              'Forgot Password?',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.kSecondaryColor),
            )
                .animate()
                .fadeIn(begin: 0, delay: 500.ms)
                .slideY(begin: .5, end: 0),
            24.0.height,
            MainButton(
              text: 'Sign In',
              onPressed: () {},
            )
                .animate()
                .fadeIn(begin: 0, delay: 500.ms)
                .slideY(begin: .5, end: 0),
            32.0.height,
            const Center(child: Text('OR')),
            24.0.height,
            Row(
              children: [
                const AuthBtn(
                  image: AppImages.google,
                ),
                16.0.width,
                const AuthBtn(
                  image: AppImages.apple,
                ),
              ],
            )
                .animate()
                .fadeIn(begin: 0, delay: 500.ms)
                .slideY(begin: .5, end: 0),
            70.0.height,
            const BottomWidget(
              isSignIn: true,
            )
          ],
        ),
      ),
    );
  }
}
