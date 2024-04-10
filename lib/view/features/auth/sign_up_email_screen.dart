import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/auth/widgets/create_account_header.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/auth_btn.dart';
import 'package:remittance_mobile/view/widgets/back_button.dart';
import 'package:remittance_mobile/view/widgets/bottom_widget.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class SignUpEmailScreen extends ConsumerStatefulWidget {
  static String path = "/sign-up";
  const SignUpEmailScreen({super.key});

  @override
  ConsumerState<SignUpEmailScreen> createState() => _SignUpEmailScreenState();
}

class _SignUpEmailScreenState extends ConsumerState<SignUpEmailScreen> {
  /// Controllers
  final TextEditingController _email = TextEditingController();
  @override
  void dispose() {
    _email.dispose();
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
          const CreateAccountHeader(),
          32.0.height,
          TextInput(
            controller: _email,
            hint: "Email",
            inputType: TextInputType.emailAddress,
            validator: validateEmail,
          ).animate().fadeIn(begin: 0, delay: 500.ms).slideY(begin: .5, end: 0),
          24.0.height,
          MainButton(
            text: 'Sign In',
            onPressed: () {},
          ).animate().fadeIn(begin: 0, delay: 500.ms).slideY(begin: .5, end: 0),
          32.0.height,
          const Center(child: Text('OR')),
          24.0.height,
          Row(
            children: [],
          ).animate().fadeIn(begin: 0, delay: 500.ms).slideY(begin: .5, end: 0),
          100.0.height,
          const BottomWidget(
            isSignIn: false,
          )
        ],
      )),
    );
  }
}
