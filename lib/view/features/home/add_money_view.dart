import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

class AddMoneyView extends StatefulWidget {
  static String path = 'add-money-view.dart';
  const AddMoneyView({super.key});

  @override
  State<AddMoneyView> createState() => _AddMoneyViewState();
}

class _AddMoneyViewState extends State<AddMoneyView> {
  final TextEditingController _paymentType = TextEditingController();
  final TextEditingController _bank = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  @override
  void dispose() {
    _paymentType.dispose();
    _bank.dispose();
    _accountNumber.dispose();
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: false,
      child: Scaffold(
        appBar: innerAppBar(title: 'Add Money'),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  /// Payment Type
                  TextInput(
                    header: 'Payment Type',
                    controller: _paymentType,
                    hint: 'Select Payment Type',
                    inputType: TextInputType.text,
                    validator: validateGeneric,
                    readOnly: true,
                    suffixIcon: SvgPicture.asset(
                      AppImages.arrowDown,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  24.0.height,

                  /// Bank
                  TextInput(
                    header: 'Bank',
                    controller: _paymentType,
                    hint: 'Select Bank',
                    inputType: TextInputType.text,
                    validator: validateGeneric,
                    readOnly: true,
                    suffixIcon: SvgPicture.asset(
                      AppImages.arrowDown,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  24.0.height,

                  /// Account Number
                  TextInput(
                    header: 'Account Number',
                    controller: _paymentType,
                    hint: 'Enter Account Number',
                    inputType: TextInputType.number,
                    maxLength: 10,
                    validator: validateGeneric,
                  ),
                  24.0.height,

                  /// Amount
                  AmountInput(
                    header: 'Amount',
                    controller: _amount,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          children: [
            const BottomNavBarBalanceInfo(),
            12.0.height,
            MainButton(
              //isLoading: true,
              text: 'Add Money',
              onPressed: () {
                AppBottomSheet.showBottomSheet(
                  context,
                  isDismissible: false,
                  widget: const BottomSheetConfirmationWidget(),
                );
              },
            )
                .animate()
                .fadeIn(begin: 0, delay: 1000.ms)
                // .then(delay: 200.ms)
                .slideY(begin: .1, end: 0),
            8.0.width,
          ],
        ),
      ),
    );
  }
}
