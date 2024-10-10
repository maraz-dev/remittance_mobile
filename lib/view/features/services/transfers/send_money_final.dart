import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_initial.dart';
import 'package:remittance_mobile/view/utils/app_bottomsheet.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/amount_input.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';
import 'package:remittance_mobile/view/widgets/bottomsheet_balance_info.dart';
import 'package:remittance_mobile/view/widgets/bottomsheet_confirmation_widget.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class SendMoneyFinalView extends StatefulWidget {
  static String path = 'send-money-final-view';
  const SendMoneyFinalView({super.key});

  @override
  State<SendMoneyFinalView> createState() => _SendMoneyFinalViewState();
}

class _SendMoneyFinalViewState extends State<SendMoneyFinalView> {
  final TextEditingController _sendAmount = TextEditingController();
  final TextEditingController _receiveAmount = TextEditingController();

  @override
  void dispose() {
    _sendAmount.dispose();
    _receiveAmount.dispose();

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

                /// Amount
                AmountInput(
                  header: "You'll Send",
                  controller: _receiveAmount,
                  currency: srcCurrencyValue.value.currencyCode,
                ),
                24.0.height,

                /// Amount
                AmountInput(
                  readOnly: true,
                  header: "Recipient Gets",
                  controller: _sendAmount,
                  currency: desCurrencyValue.value.currencyCode,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(
          children: [
            const BottomNavBarBalanceInfo(
              rateFrom: '',
              rateTo: '',
              showArrival: false,
            ),
            12.0.height,
            MainButton(
                text: 'Send Money',
                onPressed: () {
                  AppBottomSheet.showBottomSheet(
                    context,
                    isDismissible: false,
                    widget: const BottomSheetConfirmationWidget(
                      title: 'Send Money',
                      subtitle:
                          "The amount below will be added sent to 938784898 Guaranty Trust Bank",
                      buttonText: 'Send Now',
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
