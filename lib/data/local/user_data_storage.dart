// ignore_for_file: avoid_print

import 'package:remittance_mobile/core/storage/hive-storage/hive_storage.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage_service.dart';
import 'package:remittance_mobile/data/models/responses/user_response.dart';

class UserStorageService {
  final HiveStorageBase _storageService;

  UserStorageService({required HiveStorageBase storageService})
      : _storageService = storageService;

  Future<UserResponse> getUser() async {
    try {
      final result = await _storageService.get(StorageKey.userProfile.name);
      print("RESULT ----------->>> $result");

      if (result != null && result is Map) {
        final stringKeyMap = Map<String, dynamic>.from(result);
        return UserResponse.fromJson(stringKeyMap);
      } else {
        return UserResponse();
      }
    } catch (e) {
      print("This is a Storage Error $e");
      throw e.toString();
    }
  }
}
