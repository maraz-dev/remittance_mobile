import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_mobile/view/theme/app_colors.dart';
import 'package:remittance_mobile/view/utils/app_images.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/utils/input_fields.dart';
import 'package:remittance_mobile/view/utils/validator.dart';
import 'package:remittance_mobile/view/widgets/amount_input.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
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
                  16.0.height,

                  // Balance
                  BalanceWidget(
                    balance: 0.0.amountWithCurrency('usd'),
                  ).animate().slideX(begin: -.1),
                  16.0.height,

                  // Amount
                  AmountInput(
                    header: 'Amount',
                    controller: _amount,
                  ),
                  24.0.height,

                  // Payment Type
                  TextInput(
                    header: 'Fund Account With',
                    controller: _paymentType,
                    hint: 'Select Method',
                    inputType: TextInputType.text,
                    validator: validateGeneric,
                    readOnly: true,
                    suffixIcon: SvgPicture.asset(
                      AppImages.arrowDown,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          children: [
            MainButton(
              //isLoading: true,
              text: 'Next',
              onPressed: () {},
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

class BalanceWidget extends StatelessWidget {
  final String balance;
  const BalanceWidget({
    super.key,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Balance: ',
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: AppColors.kGrey500),
        ),
        4.0.width,
        Text(
          balance,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(),
        ),
      ],
    );
  }
}
