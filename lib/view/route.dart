import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
        // GoRoute(
        //   path: "/",
        //   name: OnboardingScreen.path,
        //   builder: (context, state) => const OnboardingScreen(),
        // ),

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
