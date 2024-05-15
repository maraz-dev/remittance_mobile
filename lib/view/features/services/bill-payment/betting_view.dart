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

class BettingView extends StatefulWidget {
  static String path = 'betting-view';
  const BettingView({super.key});

  @override
  State<BettingView> createState() => _BettingViewState();
}

class _BettingViewState extends State<BettingView> {
  final TextEditingController _country = TextEditingController();
  final TextEditingController _serviceProvider = TextEditingController();
  final TextEditingController _package = TextEditingController();
  final TextEditingController _userId = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  @override
  void dispose() {
    _country.dispose();
    _serviceProvider.dispose();
    _package.dispose();
    _userId.dispose();
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: false,
      child: Scaffold(
        appBar: innerAppBar(title: 'Betting'),
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
                  header: 'Service Provider',
                  controller: _serviceProvider,
                  hint: 'Select Service Provider',
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
                  header: 'User ID',
                  controller: _userId,
                  hint: 'Enter User ID',
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
                text: 'Top Up',
                onPressed: () {
                  AppBottomSheet.showBottomSheet(
                    context,
                    isDismissible: false,
                    widget: const BottomSheetConfirmationWidget(
                      title: 'Top Up Betting Account',
                      subtitle:
                          "You’re about to top-up your SportyBet account with user ID 928378273 worth",
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
