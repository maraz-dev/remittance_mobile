import 'package:flutter/material.dart';
import 'package:remittance_mobile/view/features/home/account-view/exchange/exchange_buy_option_view.dart';
import 'package:remittance_mobile/view/features/home/account-view/exchange/exchange_sell_option_view.dart';
import 'package:remittance_mobile/view/features/home/account-view/withdraw/withdrawal-sheet/custom_tab_bar.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/inner_app_bar.dart';
import 'package:remittance_mobile/view/widgets/scaffold_body.dart';

class ExchangeInitialView extends StatefulWidget {
  static const path = 'exchange-initial-view';
  const ExchangeInitialView({super.key});

  @override
  State<ExchangeInitialView> createState() => _ExchangeInitialViewState();
}

class _ExchangeInitialViewState extends State<ExchangeInitialView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(title: 'Exchange'),
      body: ScaffoldBody(
        body: Column(
          children: [
            20.0.height,

            // Exchange Tabs
            CustomTabBar(
              tabController: _tabController,
              tabs: const [
                Tab(text: 'Buy'),
                Tab(text: 'Sell'),
              ],
            ),
            24.0.height,

            // Tab Contents
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  ExchangeBuyOptionView(),
                  ExchangeSellOptionView(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
