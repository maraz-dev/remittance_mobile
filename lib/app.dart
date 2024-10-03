import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/main.dart';
import 'package:remittance_mobile/view/route.dart';
import 'package:remittance_mobile/view/theme/app_theme.dart';
import 'package:remittance_mobile/view/utils/session-manager/session_timeout_manager.dart';
import 'package:remittance_mobile/view/utils/session-manager/vm/app_session_vm.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  bool isBackground = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.detached:
        log('App Detached'.toUpperCase());
      case AppLifecycleState.resumed:
        isResume();
        log('App Resumed'.toUpperCase());
      case AppLifecycleState.inactive:
        appState();
        log('App Inactive'.toUpperCase());
      case AppLifecycleState.hidden:
        log('App Hidden'.toUpperCase());
      case AppLifecycleState.paused:
        log('App Paused'.toUpperCase());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void appState() {
    setState(() => isBackground = true);
  }

  void isResume() {
    setState(() => isBackground = false);
  }

  @override
  Widget build(BuildContext context) {
    final appRouteProvider = ref.watch(routeProvider);
    final appSession = ref.watch(appSessionProvider);

    return GestureDetector(
      onTap: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: ((context, child) {
          return SessionTimeoutManager(
            sessionConfig: appSession,
            sessionStateStream: ref.watch(sessionStateProvider).stream,
            child: MaterialApp.router(
              title: 'Remittance',
              debugShowCheckedModeBanner: false,
              theme: themeData(),
              key: navigatorKey,
              routerConfig: appRouteProvider,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(0.98)),
                  child: child!,
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
