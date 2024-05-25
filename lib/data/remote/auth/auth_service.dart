import 'package:remittance_mobile/core/http/http_service.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage_service.dart';
import 'package:remittance_mobile/core/storage/secure-storage/secure_storage.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';
import 'package:remittance_mobile/core/utils/app_url.dart';
import 'package:remittance_mobile/data/models/requests/initiate_onboarding_req.dart';
import 'package:remittance_mobile/data/models/requests/login_req.dart';

class AuthService {
  final HttpService _networkService;
  final SecureStorageBase _storage;
  final HiveStorageBase _hivestorage;

  AuthService(
      {required HttpService networkService,
      required SecureStorageBase storage,
      required HiveStorageBase hivestorage})
      : _networkService = networkService,
        _storage = storage,
        _hivestorage = hivestorage;

// Endpoint URL Instance
  final endpointUrl = ApiEndpoints.instance;

  Future<String> initiateOnboardingEndpoint(
      InitiateOnboardingReq initiateOnboardingReq) async {
    try {
      final response = await _networkService.request(
          endpointUrl.initiateOnboarding, RequestMethod.post,
          data: initiateOnboardingReq.toJson());
      return response.data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> loginEndpoint(LoginReq loginReq) async {
    try {
      final response = await _networkService.request(
          endpointUrl.login, RequestMethod.post,
          data: loginReq.toJson());
      if (response.data['message'] != 'Successful') {
        throw response.data['error']['message'];
      } else {
        final res = response.data['data'];
        _storage.saveData('token', res['token'] ?? '');
        SharedPrefManager.userId = res['id'];
        _hivestorage.set(StorageKey.userProfile.name, res);
        return response.data['message'];
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
