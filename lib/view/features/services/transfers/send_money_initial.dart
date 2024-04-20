import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_final.dart';
import 'package:remittance_mobile/view/utils/app_dropdown.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class SendMoneyInitialView extends StatefulWidget {
  static String path = 'send-money-initial-view';
  const SendMoneyInitialView({super.key});

  @override
  State<SendMoneyInitialView> createState() => _SendMoneyInitialViewState();
}

class _SendMoneyInitialViewState extends State<SendMoneyInitialView> {
  /// Global Keys
  final GlobalKey<State> _countryKey = GlobalKey();
  final GlobalKey<State> _recipientTypeKey = GlobalKey();

  final TextEditingController _country = TextEditingController();
  final TextEditingController _recipientName = TextEditingController();
  final TextEditingController _recipientType = TextEditingController();
  final TextEditingController _emailAdress = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _transactionDesc = TextEditingController();
  final TextEditingController _bankName = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  final List<String> _recipientDropDown = [
    'ErrandPay User',
    'Bank',
    'Mobile Money'
  ];

  @override
  void dispose() {
    _country.dispose();
    _recipientName.dispose();
    _phoneNumber.dispose();
    _transactionDesc.dispose();
    _recipientType.dispose();
    _emailAdress.dispose();
    _bankName.dispose();
    _accountNumber.dispose();
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: false,
      child: Scaffold(
        appBar: innerAppBar(title: 'Send Money'),
        body: ScaffoldBody(
          body: SingleChildScrollView(
            child: Column(
              children: [
                10.0.height,

                /// Country
                TextInput(
                  key: _countryKey,
                  header: 'Country',
                  controller: _country,
                  hint: 'Select your Country',
                  inputType: TextInputType.text,
                  validator: validateGeneric,
                  readOnly: true,
                  suffixIcon: SvgPicture.asset(
                    AppImages.arrowDown,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                24.0.height,

                /// Recipient Type Provider
                TextInput(
                  key: _recipientTypeKey,
                  header: 'Recipient Type',
                  controller: _recipientType,
                  hint: 'Select Recipient Type',
                  inputType: TextInputType.text,
                  validator: validateGeneric,
                  readOnly: true,
                  suffixIcon: SvgPicture.asset(
                    AppImages.arrowDown,
                    fit: BoxFit.scaleDown,
                  ),
                  onPressed: () async {
                    await platformSpecificDropdown(
                      key: _recipientTypeKey,
                      context: context,
                      items: _recipientDropDown,
                      value: _recipientType.text,
                      onChanged: (newValue) {
                        setState(() {
                          _recipientType.text = newValue ?? "";
                        });
                      },
                    );
                  },
                ),
                24.0.height,

                /// ErrandPay User Dropdown
                Visibility(
                  visible: _recipientType.text == ''
                      ? false
                      : _recipientType.text == 'ErrandPay User'
                          ? true
                          : false,
                  child: Column(
                    children: [
                      /// Recipient Name
                      TextInput(
                        header: 'Recipient Name',
                        controller: _recipientName,
                        hint: 'Enter Recipient Name',
                        inputType: TextInputType.name,
                        validator: validateGeneric,
                      ),
                      24.0.height,

                      /// Email Address
                      TextInput(
                        header: 'Email Address',
                        controller: _emailAdress,
                        hint: 'Enter Email Address',
                        inputType: TextInputType.emailAddress,
                        validator: validateEmail,
                      ),
                      24.0.height,

                      /// Phone Number
                      TextInput(
                        header: 'Phone Number',
                        controller: _phoneNumber,
                        hint: 'Enter Phone Number',
                        inputType: TextInputType.number,
                        validator: validateGeneric,
                      ),
                      24.0.height,

                      /// Transaction Descrition
                      TextInput(
                        header: 'Transaction Description',
                        controller: _transactionDesc,
                        hint: 'Enter Transaction Description',
                        inputType: TextInputType.multiline,
                        maxLines: 5,
                        validator: validateGeneric,
                      ),
                      24.0.height,
                    ],
                  ),
                ),

                /// Bank Dropdown
                Visibility(
                  visible: _recipientType.text == ''
                      ? false
                      : _recipientType.text == 'Bank'
                          ? true
                          : false,
                  child: Column(
                    children: [
                      /// Bank Name
                      TextInput(
                        header: 'Bank Name',
                        controller: _bankName,
                        hint: 'Select Bank Name',
                        inputType: TextInputType.name,
                        validator: validateGeneric,
                        readOnly: true,
                        suffixIcon: SvgPicture.asset(
                          AppImages.arrowDown,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      24.0.height,

                      /// Phone Number
                      TextInput(
                        header: 'Account Number',
                        controller: _accountNumber,
                        hint: 'Enter Account Number',
                        inputType: TextInputType.number,
                        validator: validateGeneric,
                      ),
                      24.0.height,

                      /// Transaction Descrition
                      TextInput(
                        header: 'Transaction Description',
                        controller: _transactionDesc,
                        hint: 'Enter Transaction Description',
                        inputType: TextInputType.multiline,
                        maxLines: 5,
                        validator: validateGeneric,
                      ),
                      24.0.height,
                    ],
                  ),
                ),

                /// Mobile Money Dropdown
                Visibility(
                  visible: _recipientType.text == ''
                      ? false
                      : _recipientType.text == 'Mobile Money'
                          ? true
                          : false,
                  child: Column(
                    children: [
                      /// Phone Number
                      TextInput(
                        header: 'Phone Number',
                        controller: _phoneNumber,
                        hint: 'Enter Phone Number',
                        inputType: TextInputType.number,
                        validator: validateGeneric,
                      ),
                      24.0.height,

                      /// Transaction Descrition
                      TextInput(
                        header: 'Transaction Description',
                        controller: _transactionDesc,
                        hint: 'Enter Transaction Description',
                        inputType: TextInputType.multiline,
                        maxLines: 5,
                        validator: validateGeneric,
                      ),
                      24.0.height,
                    ],
                  ),
                ),

                24.0.height,
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          children: [
            MainButton(
              text: 'Continue',
              onPressed: () {
                context.pushNamed(SendMoneyFinalView.path);
              },
            )
                .animate()
                .fadeIn(begin: 0, delay: 1000.ms)
                // .then(delay: 200.ms)
                .slideY(begin: .1, end: 0)
          ],
        ),
      ),
    );
  }
}
