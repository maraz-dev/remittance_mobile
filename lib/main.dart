import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage_service.dart';
import 'package:remittance_mobile/core/third-party/environment.dart';
import 'package:remittance_mobile/core/utils/logger.dart';
import 'package:remittance_mobile/view/route.dart';
import 'package:remittance_mobile/view/theme/app_theme.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await initializeCore(environment: Environmentx.dev);

    final HiveStorageBase initializeStorageService = HiveStorageService();
    await initializeStorageService.init();

    final container = ProviderContainer(
      overrides: [
        hiveStorageService.overrideWithValue(initializeStorageService),
      ],
    );

    runApp(
      UncontrolledProviderScope(
        container: container,
        child: const MyApp(),
      ),
    );
  }, (error, stack) {
    logger.error(error.toString());
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appRouteProvider = ref.watch(routeProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: ((context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: themeData(),
          routerConfig: appRouteProvider,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(0.98)),
              child: child!,
            );
          },
        );
      }),
    );
  }
}
