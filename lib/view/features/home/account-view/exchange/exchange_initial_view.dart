import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remittance_mobile/view/features/home/account-view/withdraw/withdrawal-sheet/custom_tab_bar.dart';
import 'package:remittance_mobile/view/utils/extensions.dart';
import 'package:remittance_mobile/view/widgets/amount_input.dart';
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
  // Text Editing Controllers
  final TextEditingController _amount = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _amount.dispose();
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
              children: [
                Column(
                  children: [
                    AmountInput(
                      controller: _amount,
                      header: 'Amount',
                    )
                  ],
                ),
                const Center(
                  child: Text('Sell'),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
