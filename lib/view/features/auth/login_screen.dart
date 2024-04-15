import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/create_account_view.dart';
import 'package:remittance_mobile/view/features/auth/widgets/auth_title.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/back_button.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/richtext_widget.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';
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
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              32.0.height,
              const BackArrowButton(),
              18.0.height,
              const AuthTitle(
                title: 'Log In',
                subtitle: 'Send money across the world',
              ),
              32.0.height,
              TextInput(
                header: 'Email Address',
                controller: _email,
                hint: "Enter Email Address",
                inputType: TextInputType.emailAddress,
                validator: validateEmail,
              ),
              16.0.height,
              PasswordInput(
                header: 'Password',
                controller: _password,
                hint: '********',
                inputType: TextInputType.visiblePassword,
                validator: validatePassword,
              ),
              10.0.height,
              Text(
                'Forgot Password?',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.kPrimaryColor),
              )
                  .animate()
                  .fadeIn(begin: 0, delay: 500.ms)
                  .slideY(begin: .5, end: 0),
              24.0.height,
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        height: 120.h,
        children: [
          RichTextWidget(
            text: "Don't have an Account?",
            hyperlink: ' Sign Up',
            onTap: () => context.pushNamed(CreateAccountView.path),
          ),
          12.0.height,
          Row(
            children: [
              Expanded(
                flex: 6,
                child: MainButton(
                  //isLoading: true,
                  text: 'Log In',
                  onPressed: () {},
                )
                    .animate()
                    .fadeIn(begin: 0, delay: 1000.ms)
                    // .then(delay: 200.ms)
                    .slideY(begin: .1, end: 0),
              ),
              8.0.width,
              Expanded(
                flex: 1,
                child: InkWell(
                  splashColor: Colors.transparent,
                  radius: 0,
                  onTap: null,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.kWhiteColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.kBorderColor),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.kBoxShadowColor,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        )
                      ],
                    ),
                    child: SvgPicture.asset(
                      AppImages.fingerprint,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
