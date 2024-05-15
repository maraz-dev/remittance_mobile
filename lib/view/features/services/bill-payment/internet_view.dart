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

class InternetView extends StatefulWidget {
  static String path = 'internet-view';
  const InternetView({super.key});

  @override
  State<InternetView> createState() => _InternetViewState();
}

class _InternetViewState extends State<InternetView> {
  final TextEditingController _country = TextEditingController();
  final TextEditingController _networkProvider = TextEditingController();
  final TextEditingController _package = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  @override
  void dispose() {
    _country.dispose();
    _networkProvider.dispose();
    _package.dispose();
    _phoneNumber.dispose();
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: false,
      child: Scaffold(
        appBar: innerAppBar(title: 'Internet'),
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

                /// Service Provider
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

                /// Package
                TextInput(
                  header: 'Package',
                  controller: _package,
                  hint: 'Select Package',
                  inputType: TextInputType.text,
                  validator: validateGeneric,
                  readOnly: true,
                  suffixIcon: SvgPicture.asset(
                    AppImages.arrowDown,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                24.0.height,

                /// User ID
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
                text: 'Purchase Internet',
                onPressed: () {
                  AppBottomSheet.showBottomSheet(
                    context,
                    isDismissible: false,
                    widget: const BottomSheetConfirmationWidget(
                      title: 'Purchase Internet',
                      subtitle:
                          "You’re about to purchase an internet plan of 7GB for 7 Days from MTN Nigeria to 0802723673 worth",
                      buttonText: 'Top Up',
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
