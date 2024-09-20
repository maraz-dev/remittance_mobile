import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/home/account-view/payments_methods_view.dart';
import 'package:remittance_mobile/view/features/home/currency_account_view.dart';
import 'package:remittance_mobile/view/features/home/widgets/balance_widget.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/amount_input.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';

final ValueNotifier<String> addMoneyAmount = ValueNotifier("");

class AddMoneyView extends StatefulWidget {
  static String path = 'add-money-view.dart';
  const AddMoneyView({super.key});

  @override
  State<AddMoneyView> createState() => _AddMoneyViewState();
}

class _AddMoneyViewState extends State<AddMoneyView> {
  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Text Editing Controllers
  final TextEditingController _paymentType = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  @override
  void dispose() {
    _paymentType.dispose();
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    16.0.height,

                    // Balance
                    BalanceWidget(
                      balance: accountInfo.value.balance?.amountWithCurrency(
                              accountInfo
                                      .value.currencyResponse?.currencySymbol ??
                                  "") ??
                          0.0.amountWithCurrency(accountInfo
                                  .value.currencyResponse?.currencySymbol ??
                              ""),
                    ).animate().slideX(begin: -.1),
                    16.0.height,

                    // Amount
                    AmountInput(
                      header: 'Amount',
                      controller: _amount,
                      currency: accountInfo.value.currency,
                      image: accountInfo.value.currencyResponse?.flagPng,
                    ),
                    24.0.height,

                    // // Payment Type
                    // TextInput(
                    //   header: 'Fund Account With',
                    //   controller: _paymentType,
                    //   hint: 'Select Method',
                    //   inputType: TextInputType.text,
                    //   validator: validateGeneric,
                    //   readOnly: true,
                    //   suffixIcon: SvgPicture.asset(
                    //     AppImages.arrowDown,
                    //     fit: BoxFit.scaleDown,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          children: [
            MainButton(
              //isLoading: true,
              text: 'Next',
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (_formKey.currentState!.validate()) {
                  addMoneyAmount.value = _amount.text;
                  context.pushNamed(PaymentMethodView.path);
                }
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
