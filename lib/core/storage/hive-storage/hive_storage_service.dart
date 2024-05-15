import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage.dart';

/// [StorageService] interface implementation using the Hive package
///
/// See: https://pub.dev/packages/hive_flutter
class HiveStorageService implements HiveStorageBase {
  /// A Hive Box
  late Box<dynamic> hiveBox;

  /// Opens a Hive box by its name
  Future<Box<T>> openBox<T>(String boxName) async {
    return await Hive.openBox<T>(boxName);
  }

  Future<void> openAppBox([String boxName = 'SMART_PAY_APP']) async {
    hiveBox = await Hive.openBox<dynamic>(boxName);
  }

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    // Register the adapter for the UserProfile class
    //Hive.registerAdapter(UserProfileAdapter());
    await openAppBox();
    //await openBox<UserProfileDTO>(StorageKey.userProfile.name);
  }

  @override
  Future<void> remove(String key) async {
    await hiveBox.delete(key);
  }

  @override
  dynamic get(String key) {
    final result = hiveBox.get(key);

    return result;
  }

  @override
  dynamic getAll() {
    return hiveBox.values.toList();
  }

  @override
  bool has(String key) {
    return hiveBox.containsKey(key);
  }

  @override
  Future<void> set(String? key, dynamic data) async {
    try {
      await hiveBox.put(key, data);
      log("------> User Data Saved");
    } catch (e) {
      log(e.toString());

      throw e.toString();
    }
  }

  @override
  Future<void> clear() async {
    await hiveBox.clear();
  }

  @override
  Future<void> close() async {
    await hiveBox.close();
  }

  @override
  add(List value) async {
    await hiveBox.add(value);
  }
}

enum StorageKey {
  userProfile,
}

class Bee {
  Bee({required this.name, required this.role});

  factory Bee.fromJson(Map<String, dynamic> json) => Bee(
        name: json['name'] as String,
        role: json['role'] as String,
      );

  final String name;
  final String role;

  Map<String, dynamic> toJson() => {
        'name': name,
        'role': role,
      };
}
