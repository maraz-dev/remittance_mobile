import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/view/features/auth/login_screen.dart';
import 'package:remittance_mobile/view/features/auth/sign_up_email_screen.dart';

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
          path: SignUpEmailScreen.path,
          name: SignUpEmailScreen.path,
          builder: (context, state) => const SignUpEmailScreen(),
        ),

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
