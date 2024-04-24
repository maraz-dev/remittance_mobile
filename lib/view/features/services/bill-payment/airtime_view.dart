import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/amount_input.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/bottomsheet_balance_info.dart';
import 'package:remittance_mobile/view/widgets/bottomsheet_confirmation_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class AirtimeView extends StatefulWidget {
  static String path = 'airtime-view';
  const AirtimeView({super.key});

  @override
  State<AirtimeView> createState() => _AirtimeViewState();
}

class _AirtimeViewState extends State<AirtimeView> {
  final TextEditingController _country = TextEditingController();
  final TextEditingController _networkProvider = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _meterNumber = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  @override
  void dispose() {
    _country.dispose();
    _networkProvider.dispose();
    _phoneNumber.dispose();
    _meterNumber.dispose();
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: false,
      child: Scaffold(
        appBar: innerAppBar(title: 'Airtime'),
        body: ScaffoldBody(
          body: SingleChildScrollView(
            child: Column(
              children: [
                10.0.height,

                /// Country
                TextInput(
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

                /// Network Provider
                TextInput(
                  header: 'Network Provider',
                  controller: _networkProvider,
                  hint: 'Select Network Provider',
                  inputType: TextInputType.text,
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
                  header: 'Phone Number',
                  controller: _phoneNumber,
                  hint: 'Enter Phone Number',
                  inputType: TextInputType.number,
                  validator: validateGeneric,
                ),
                24.0.height,

                /// Amount
                AmountInput(
                  header: 'Amount',
                  controller: _amount,
                ),
                24.0.height
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          children: [
            const BottomNavBarBalanceInfo(),
            12.0.height,
            MainButton(
                text: 'Purchase Airtime',
                onPressed: () {
                  AppBottomSheet.showBottomSheet(
                    context,
                    isDismissible: false,
                    widget: const BottomSheetConfirmationWidget(
                      title: 'Purchase Airtime',
                      subtitle:
                          "You’re about to purchase airtime from MTN Nigeria to 0802723673 worth",
                      buttonText: 'Buy Now',
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
