import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/data/models/requests/initiate_onboarding_req.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/choose_country_view.dart';
import 'package:remittance_mobile/view/features/auth/vm/create_account_vm/initiate_onboarding_vm.dart';
import 'package:remittance_mobile/view/features/auth/widgets/auth_title.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart' as input;
import 'package:remittance_mobile/view/utils/snackbar.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/back_button.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';

ValueNotifier<String> successfulCreatedEmail = ValueNotifier('');
ValueNotifier<String> successfulCreatedPhoneNo = ValueNotifier('');

class CreateAccountFormView extends ConsumerStatefulWidget {
  static String path = 'create-account-form-view';

  final VoidCallback pressed;
  const CreateAccountFormView({
    super.key,
    required this.pressed,
  });

  @override
  ConsumerState<CreateAccountFormView> createState() => _CreateAccountFormViewState();
}

class _CreateAccountFormViewState extends ConsumerState<CreateAccountFormView> {
  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Text Editing Controllers
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _middleName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneNumber.text = selectedCountry.value.phoneCode;

    _phoneNumber.addListener(() {
      final text = _phoneNumber.text;
      // If the text doesn't start with the Pinned part, reset it
      if (!text.startsWith(selectedCountry.value.phoneCode)) {
        _phoneNumber.value = TextEditingValue(
          text: selectedCountry.value.phoneCode,
          selection: TextSelection.fromPosition(
            TextPosition(
              offset: selectedCountry.value.phoneCode.toString().length,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _firstName.dispose();
    _middleName.dispose();
    _lastName.dispose();
    _emailAddress.dispose();
    _phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(initiateOnboardingProvider);

    // Endpoint State
    ref.listen(initiateOnboardingProvider, (_, next) {
      if (next is AsyncData<String>) {
        setState(() {
          successfulCreatedEmail.value = _emailAddress.text;
          successfulCreatedPhoneNo.value = _phoneNumber.text;
        });

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
                        input.TextInput(
                          header: 'First Name',
                          controller: _firstName,
                          hint: "Enter your First Name",
                          inputType: TextInputType.text,
                          validator: validateGeneric,
                        ),
                        16.0.height,
                        input.TextInput(
                          header: 'Middle Name',
                          controller: _middleName,
                          hint: "Enter your Middle Name",
                          inputType: TextInputType.text,
                          validator: null,
                        ),
                        16.0.height,
                        input.TextInput(
                          header: 'Last Name',
                          controller: _lastName,
                          hint: "Enter your Last Name",
                          inputType: TextInputType.text,
                          validator: validateGeneric,
                        ),
                        16.0.height,
                        input.TextInput(
                          header: 'Email Address',
                          controller: _emailAddress,
                          hint: "Enter your Email Address",
                          inputType: TextInputType.emailAddress,
                          validator: validateEmail,
                        ),
                        16.0.height,
                        input.TextInput(
                          header: 'Phone Number',
                          controller: _phoneNumber,
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                selectedCountry.value.flagPng ?? '',
                                fit: BoxFit.contain,
                                width: 30,
                              ),
                            ],
                          ),
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          hint: "(+${selectedCountry.value.phoneCode})",
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
        ),
        bottomNavigationBar: BottomNavBarWidget(
          children: [
            MainButton(
              isLoading: loading.isLoading,
              text: 'Continue',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ref.read(initiateOnboardingProvider.notifier).initiateOnboardingMethod(
                        InitiateOnboardingReq(
                          firstName: _firstName.text.trim(),
                          middleName: _middleName.text.trim(),
                          lastName: _lastName.text.trim(),
                          email: _emailAddress.text.trim(),
                          customerType: 'Individual',
                          countryCode: selectedCountry.value.code,
                          phoneNumber: _phoneNumber.text,
                        ),
                      );
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
