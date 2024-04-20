import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/auth/login_screen.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/create_account_view.dart';
import 'package:remittance_mobile/view/features/dashboard/dashboard_view.dart';
import 'package:remittance_mobile/view/features/home/add_money_view.dart';
import 'package:remittance_mobile/view/features/home/currency_account_view.dart';
import 'package:remittance_mobile/view/features/home/home_view.dart';
import 'package:remittance_mobile/view/features/services/bill-payment/airtime_view.dart';
import 'package:remittance_mobile/view/features/services/bill-payment/betting_view.dart';
import 'package:remittance_mobile/view/features/services/bill-payment/cable_tv_view.dart';
import 'package:remittance_mobile/view/features/services/bill-payment/electricity_view.dart';
import 'package:remittance_mobile/view/features/services/bill-payment/internet_view.dart';
import 'package:remittance_mobile/view/features/services/services_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/receive_money_view.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_final.dart';
import 'package:remittance_mobile/view/features/services/transfers/send_money_initial.dart';
import 'package:remittance_mobile/view/features/services/virtual-cards/virtual_cards_empty_view.dart';
import 'package:remittance_mobile/view/features/transactions/transaction_details.dart';

final GlobalKey<NavigatorState> rootNavigation = GlobalKey(debugLabel: "root");
final GlobalKey<NavigatorState> shellNavigation =
    GlobalKey(debugLabel: "shell");

final routeProvider = Provider<GoRouter>((ref) {
  return GoRouter(
      initialLocation: "/",
      navigatorKey: rootNavigation,
      debugLogDiagnostics: true,
      restorationScopeId: "app",
      redirect: (context, state) {
        return null;
      },
      routes: [
        GoRoute(
          path: "/",
          name: LoginScreen.path,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: CreateAccountView.path,
          name: CreateAccountView.path,
          builder: (context, state) => const CreateAccountView(),
        ),
        GoRoute(
          path: DashboardView.path,
          name: DashboardView.path,
          builder: (context, state) => const DashboardView(),
        ),
        GoRoute(
            path: HomeView.path,
            name: HomeView.path,
            builder: (context, state) => const HomeView(),
            routes: [
              GoRoute(
                path: CurrencyAccountView.path,
                name: CurrencyAccountView.path,
                builder: (context, state) => const CurrencyAccountView(),
              ),
              GoRoute(
                path: AddMoneyView.path,
                name: AddMoneyView.path,
                builder: (context, state) => const AddMoneyView(),
              ),
              GoRoute(
                path: AddMoneyTransactionDetails.path,
                name: AddMoneyTransactionDetails.path,
                builder: (context, state) => const AddMoneyTransactionDetails(),
              ),
            ]),
        GoRoute(
            path: ServicesView.path,
            name: ServicesView.path,
            builder: (context, state) => const ServicesView(),
            routes: [
              GoRoute(
                path: BettingView.path,
                name: BettingView.path,
                builder: (context, state) => const BettingView(),
              ),
              GoRoute(
                path: ElectricityView.path,
                name: ElectricityView.path,
                builder: (context, state) => const ElectricityView(),
              ),
              GoRoute(
                path: CableTvView.path,
                name: CableTvView.path,
                builder: (context, state) => const CableTvView(),
              ),
              GoRoute(
                path: AirtimeView.path,
                name: AirtimeView.path,
                builder: (context, state) => const AirtimeView(),
              ),
              GoRoute(
                path: InternetView.path,
                name: InternetView.path,
                builder: (context, state) => const InternetView(),
              ),
              GoRoute(
                path: SendMoneyInitialView.path,
                name: SendMoneyInitialView.path,
                builder: (context, state) => const SendMoneyInitialView(),
              ),
              GoRoute(
                path: SendMoneyFinalView.path,
                name: SendMoneyFinalView.path,
                builder: (context, state) => const SendMoneyFinalView(),
              ),
              GoRoute(
                path: ReceiveMoneyView.path,
                name: ReceiveMoneyView.path,
                builder: (context, state) => const ReceiveMoneyView(),
              ),
              GoRoute(
                path: VirtualCardEmptyView.path,
                name: VirtualCardEmptyView.path,
                builder: (context, state) => const VirtualCardEmptyView(),
              ),
            ])

        // GoRoute(
        //     path: SMSScreen.path,
        //     name: SMSScreen.path,
        //     builder: (context, state) => const SMSScreen(),
        //     routes: [
        //       GoRoute(
        //         path: SMSDetailsScreen.path,
        //         name: SMSDetailsScreen.path,
        //         builder: (context, state) => const SMSDetailsScreen(),
        //       ),
        //     ]),
      ]);
});
