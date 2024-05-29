import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/choose_country_view.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class PersonalDetailsView extends StatefulWidget {
  static String path = 'personal-details-view';
  const PersonalDetailsView({super.key});

  @override
  State<PersonalDetailsView> createState() => _PersonalDetailsViewState();
}

class _PersonalDetailsViewState extends State<PersonalDetailsView> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _emailAddress = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fullName.text = 'Adebola Sanni';
    _phoneNumber.text = '(+1) 8738 9738 9382';
    _address.text = '2464 Royal Ln. Mesa, New Jersey 45463';
    _country.text = 'United States';
    _emailAddress.text = 'pinkybolar@gmail.com';
  }

  @override
  void dispose() {
    _fullName.dispose();
    _phoneNumber.dispose();
    _address.dispose();
    _country.dispose();
    _emailAddress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Personal Details'),
      body: ScaffoldBody(
        body: SingleChildScrollView(
          child: Column(
            children: [
              24.0.height,

              /// Full Name
              TextInput(
                header: 'Full Name',
                controller: _fullName,
                hint: "Enter your Full Name",
                inputType: TextInputType.name,
                validator: validateGeneric,
                readOnly: true,
              ),
              16.0.height,

              /// Phone Number
              TextInput(
                header: 'Phone Number',
                controller: _phoneNumber,
                prefixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      selectedCountry.value.code ?? "",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.kBlackColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                hint: "(+${selectedCountry.value.phoneCode})",
                inputType: TextInputType.number,
                validator: validateGeneric,
                readOnly: true,
              ),
              16.0.height,

              /// Address
              TextInput(
                header: 'Address',
                controller: _address,
                hint: "Enter your Address",
                inputType: TextInputType.name,
                maxLines: 1,
                validator: validateGeneric,
                readOnly: true,
              ),
              16.0.height,

              /// Full Name
              TextInput(
                header: 'Country',
                controller: _country,
                hint: "Enter your Country",
                inputType: TextInputType.name,
                validator: validateGeneric,
                readOnly: true,
              ),
              16.0.height,

              /// Email Address
              TextInput(
                header: 'Email Address',
                controller: _emailAddress,
                hint: "Enter your Email Address",
                inputType: TextInputType.emailAddress,
                validator: validateEmail,
                readOnly: true,
              ),
              16.0.height,
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        children: [
          MainButton(
            //isLoading: true,
            text: 'Save Changes',
            onPressed: () {},
            color: AppColors.kPrimaryColor.withOpacity(0.3),
          )
              .animate()
              .fadeIn(begin: 0, delay: 1000.ms)
              // .then(delay: 200.ms)
              .slideY(begin: .1, end: 0),
        ],
      ),
    );
  }
}
