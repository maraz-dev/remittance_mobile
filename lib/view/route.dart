import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/auth/login_screen.dart';
import 'package:remittance_mobile/view/features/auth/create_account_flow/create_account_view.dart';
import 'package:remittance_mobile/view/features/dashboard/dashboard_view.dart';
import 'package:remittance_mobile/view/features/home/add_money_view.dart';
import 'package:remittance_mobile/view/features/home/currency_account_view.dart';
import 'package:remittance_mobile/view/features/home/home_view.dart';
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
