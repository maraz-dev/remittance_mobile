import 'package:remittance_mobile/core/http/http_service.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage_service.dart';
import 'package:remittance_mobile/core/storage/secure-storage/secure_storage.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';
import 'package:remittance_mobile/core/utils/app_url.dart';
import 'package:remittance_mobile/data/models/requests/create_password_req.dart';
import 'package:remittance_mobile/data/models/requests/initiate_onboarding_req.dart';
import 'package:remittance_mobile/data/models/requests/login_req.dart';
import 'package:remittance_mobile/data/models/requests/security_questions_req.dart';
import 'package:remittance_mobile/data/models/requests/set_pin_req.dart';
import 'package:remittance_mobile/data/models/requests/validate_pin_req.dart';
import 'package:remittance_mobile/data/models/requests/verify_phone_number_req.dart';
import 'package:remittance_mobile/data/models/responses/new_country_model.dart';
import 'package:remittance_mobile/data/models/responses/security_question.dart';

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
        endpointUrl.initiateOnboarding,
        RequestMethod.post,
        data: initiateOnboardingReq.toJson(),
      );
      if (response.data['message'] != 'Successful') {
        throw response.data['error']['message'];
      } else {
        final res = response.data;
        _storage.saveData('requestId', res['requestId'] ?? '');
        return res['requestId'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> loginEndpoint(LoginReq loginReq) async {
    try {
      final response = await _networkService.request(
        endpointUrl.login,
        RequestMethod.post,
        data: loginReq.toJson(),
      );
      if (response.data['message'] != 'Successful') {
        throw response.data['error']['message'];
      } else {
        final res = response.data['data'];
        _storage.saveData('token', res['token'] ?? '');
        SharedPrefManager.userId = res['userId'];
        _hivestorage.set(StorageKey.userProfile.name, res);
        return response.data['message'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> verifyPhoneNoEndpoint(
      VerifyPhoneNumberReq verifyPhoneNumberReq) async {
    try {
      final response = await _networkService.request(
        endpointUrl.verifyPhoneNumber,
        RequestMethod.post,
        data: verifyPhoneNumberReq.toJson(),
      );
      if (response.data['message'] != 'Successful') {
        throw response.data['error']['message'];
      } else {
        final res = response.data;
        _storage.saveData('requestId', res['requestId'] ?? '');
        return res['requestId'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> createPasswordEndpoint(
      CreatePasswordReq createPasswordReq) async {
    try {
      final response = await _networkService.request(
        endpointUrl.createPassword,
        RequestMethod.post,
        data: createPasswordReq.toJson(),
      );
      if (response.data['message'] != 'Successful') {
        throw response.data['error']['message'];
      } else {
        final res = response.data;

        _storage.saveData('requestId', res['requestId'] ?? '');
        return res['requestId'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<NewCountryModel>> getCountriesEndpoint() async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseUrlTwo + endpointUrl.getCountries,
        RequestMethod.get,
      );
      if (response.data['message'] != 'Successful') {
        throw response.data['error']['message'];
      } else {
        final res = response.data['data'] as List;
        final responseList =
            res.map((json) => NewCountryModel.fromJson(json)).toList();
        return responseList;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> setPinEndpoint(SetPinReq setPinReq) async {
    try {
      final response = await _networkService.request(
        endpointUrl.setPin,
        RequestMethod.post,
        data: setPinReq.toJson(),
      );
      if (response.data['message'] != 'Successful') {
        throw response.data['error']['message'];
      } else {
        return response.data['message'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> validatePinEndpoint(String pin) async {
    try {
      final response = await _networkService.request(
        endpointUrl.validatePin,
        RequestMethod.post,
        data: ValidatePinReq(
          emailAddress: SharedPrefManager.email,
          pin: pin,
        ).toJson(),
      );
      if (response.data['message'] != 'Successful') {
        throw response.data['error']['message'];
      } else {
        return response.data['message'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<SecurityQuestionItem>> getSecurityQuestionEndpoint() async {
    try {
      final response = await _networkService.request(
        endpointUrl.getSecurityQuestion,
        RequestMethod.get,
      );
      if (response.data['message'] != 'Successful') {
        throw response.data['error']['message'];
      } else {
        final res = response.data['data'] as List;
        final responseList =
            res.map((json) => SecurityQuestionItem.fromJson(json)).toList();
        return responseList;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> setSecurityQuestionEndpoint(
      SecurityQuestionReq securityQuestionReq) async {
    try {
      final response = await _networkService.request(
        endpointUrl.setSecurityQuestion,
        RequestMethod.post,
        data: securityQuestionReq.toJson(),
      );
      if (response.data['message'] != 'Successful') {
        throw response.data['error']['message'];
      } else {
        return response.data['message'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> validateSecurityQuestionEndpoint(
      SecurityQuestionReq securityQuestionReq) async {
    try {
      final response = await _networkService.request(
        endpointUrl.validateSecurityQuestion,
        RequestMethod.post,
        data: securityQuestionReq.toJson(),
      );
      if (response.data['message'] != 'Successful') {
        throw response.data['error']['message'];
      } else {
        return response.data['message'];
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
