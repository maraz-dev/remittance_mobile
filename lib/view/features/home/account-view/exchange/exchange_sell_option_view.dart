import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:remittance_mobile/view/features/home/account-view/exchange/exchange_receive_money_view.dart';
import 'package:remittance_mobile/view/utils/buttons.dart';
import 'package:remittance_mobile/view/widgets/bottom_nav_bar_widget.dart';

class ExchangeSellOptionView extends StatefulWidget {
  const ExchangeSellOptionView({super.key});

  @override
  State<ExchangeSellOptionView> createState() => _ExchangeSellOptionViewState();
}

class _ExchangeSellOptionViewState extends State<ExchangeSellOptionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Sell'),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        children: [
          MainButton(
            text: 'Next',
            onPressed: () {
              context.pushNamed(ExchangeReceiveMoneyOptionsView.path);
            },
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
