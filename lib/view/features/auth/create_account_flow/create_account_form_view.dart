import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/choose_country_view.dart';
import 'package:remittance_mobile/view/features/auth/widgets/auth_title.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/back_button.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';

class CreateAccountFormView extends ConsumerStatefulWidget {
  final VoidCallback pressed;
  const CreateAccountFormView({
    super.key,
    required this.pressed,
  });

  @override
  ConsumerState<CreateAccountFormView> createState() =>
      _CreateAccountFormViewState();
}

class _CreateAccountFormViewState extends ConsumerState<CreateAccountFormView> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _middleName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
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
                  title: 'Create Account',
                  subtitle:
                      'Enter your personal information as show on your government issue ID.'),
              32.0.height,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInput(
                        header: 'First Name',
                        controller: _firstName,
                        hint: "Enter your First Name",
                        inputType: TextInputType.name,
                        validator: validateGeneric,
                      ),
                      16.0.height,
                      TextInput(
                        header: 'Middle Name',
                        controller: _middleName,
                        hint: "Enter your Middle Name",
                        inputType: TextInputType.name,
                        validator: validateGeneric,
                      ),
                      16.0.height,
                      TextInput(
                        header: 'Last Name',
                        controller: _lastName,
                        hint: "Enter your Last Name",
                        inputType: TextInputType.name,
                        validator: validateGeneric,
                      ),
                      16.0.height,
                      TextInput(
                        header: 'Email Address',
                        controller: _emailAddress,
                        hint: "Enter your Email Address",
                        inputType: TextInputType.emailAddress,
                        validator: validateEmail,
                      ),
                      16.0.height,
                      TextInput(
                        header: 'Phone Number',
                        controller: _phoneNumber,
                        prefixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              selectedCountry.value.code ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: AppColors.kBlackColor,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        hint: "(+${selectedCountry.value.dialCode})",
                        inputType: TextInputType.number,
                        validator: validateGeneric,
                      ),
                      16.0.height,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          children: [
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
