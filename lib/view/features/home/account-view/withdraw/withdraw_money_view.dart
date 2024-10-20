import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/home/account-view/payments_methods_view.dart';
import 'package:remittance_mobile/view/features/home/account-view/withdraw/withdrawal-sheet/add_withdrawal_account.dart';
import 'package:remittance_mobile/view/features/home/widgets/add_withdraw_acct_card.dart';
import 'package:remittance_mobile/view/features/home/widgets/balance_widget.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/amount_input.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';

class WithdrawMoneyView extends StatefulWidget {
  static String path = 'withdraw-money-view.dart';
  const WithdrawMoneyView({super.key});

  @override
  State<WithdrawMoneyView> createState() => _WithdrawMoneyViewState();
}

class _WithdrawMoneyViewState extends State<WithdrawMoneyView> {
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
        appBar: innerAppBar(title: 'Withdraw Money'),
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
                    animate: false,
                  ),
                  16.0.height,

                  // Add Withdrawal Bank
                  AddWithdrawalBankAccountCard(
                    onPressed: () {
                      AppBottomSheet.showBottomSheet(
                        context,
                        widget: const AddBankAccountSheet(
                          route: BankRoute.withdrawal,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          children: [
            MainButton(
              //isLoading: true,
              text: 'Withdraw',
              onPressed: () {
                context.pushNamed(PaymentMethodView.path);
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
