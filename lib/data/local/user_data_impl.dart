import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/local/user_data_storage.dart';
import 'package:remittance_mobile/data/models/responses/user_response.dart';

abstract class UserRepository {
  Future<UserResponse> fetchUserProfile();
}

abstract class UserDataStorage implements UserRepository {
  final UserStorageService _service;

  UserDataStorage(this._service);

  @override
  Future<UserResponse> fetchUserProfile() async => _service.getUser();
}

final localUserProvider = FutureProvider.autoDispose((ref) async {
  return ref.watch(userStorageService).getUser();
});
