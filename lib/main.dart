import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/app.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage_service.dart';
import 'package:remittance_mobile/core/third-party/environment.dart';
import 'package:remittance_mobile/core/utils/logger.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    // Switch the Working Environment for the Endpoints
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
