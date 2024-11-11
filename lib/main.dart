import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/app.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage_service.dart';
import 'package:remittance_mobile/core/third-party/environment.dart';
import 'package:remittance_mobile/core/utils/logger.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

EventBus eventBus = EventBus();

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    // Switch the Working Environment for the Endpoints
    await initializeCore(environment: Environmentx.prod);

    // Initialize the .env Environments
    await dotenv.load(fileName: ".env");

    final HiveStorageBase initializeStorageService = HiveStorageService();
    await initializeStorageService.init();

    eventBus.on().listen((event) {});

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
