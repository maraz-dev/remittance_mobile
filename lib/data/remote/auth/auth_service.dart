import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:remittance_mobile/core/http/http_service.dart';
import 'package:remittance_mobile/core/http/response_body_handler.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage_service.dart';
import 'package:remittance_mobile/core/storage/secure-storage/secure_storage.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';
import 'package:remittance_mobile/core/utils/app_url.dart';
import 'package:remittance_mobile/data/models/requests/complete_forgot_password_req.dart';
import 'package:remittance_mobile/data/models/requests/create_password_req.dart';
import 'package:remittance_mobile/data/models/requests/forgot_pass_verify_otp.dart';
import 'package:remittance_mobile/data/models/requests/initiate_forgot_password_req.dart';
import 'package:remittance_mobile/data/models/requests/initiate_onboarding_req.dart';
import 'package:remittance_mobile/data/models/requests/login_req.dart';
import 'package:remittance_mobile/data/models/requests/security_questions_req.dart';
import 'package:remittance_mobile/data/models/requests/set_pin_req.dart';
import 'package:remittance_mobile/data/models/requests/set_security_question_req.dart';
import 'package:remittance_mobile/data/models/requests/validate_pin_req.dart';
import 'package:remittance_mobile/data/models/requests/verify_phone_number_req.dart';
import 'package:remittance_mobile/data/models/responses/kyc_status_model.dart';
import 'package:remittance_mobile/data/models/responses/kyc_submission_model.dart';
import 'package:remittance_mobile/data/models/responses/new_country_model.dart';
import 'package:remittance_mobile/data/models/responses/security_question_item_model.dart';

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

  // Class to Handle API Response
  final ResponseHandler _responseHandler = ResponseHandler();

  /// This Method is to get the device details for Security Purposes
  Future<List<String?>> _getDeviceDetails() async {
    String? deviceType;
    String? deviceToken;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceType = iosInfo.utsname.nodename;
      deviceToken = iosInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceType = androidInfo.model;
      deviceToken = androidInfo.id;
    }
    return [deviceType, deviceToken];
  }

  Future<String> loginEndpoint(LoginReq loginReq) async {
    // Device Details Variable
    String? deviceType;
    String? deviceToken;

    try {
      // Get Device Details
      await _getDeviceDetails().then((value) {
        deviceType = value[0];
        deviceToken = value[1];
      });

      // Make Request
      final response = await _networkService.request(
        endpointUrl.login,
        RequestMethod.post,
        data: loginReq
            .copyWith(
              partnerCode: endpointUrl.partnerCode,
              deviceType: deviceType,
              deviceToken: deviceToken,
            )
            .toJson(),
      );

      // Handle the Response
      _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          _storage.saveData('token', res['token'] ?? '');
          _hivestorage.set(StorageKey.userProfile.name, res);
          SharedPrefManager.userId = res['userId'];
          SharedPrefManager.email = res['email'];
          SharedPrefManager.isNewLogin = res['isNewLogin'];
          SharedPrefManager.isPINSet = res['isPINSet'];
          SharedPrefManager.isKycComplete = res['isKycComplete'];
          SharedPrefManager.isSecurityQuestionSet =
              res['isSecurityQuestionSet'];
        },
      );
      return response.data['message'];
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> initiateOnboardingEndpoint(
      InitiateOnboardingReq initiateOnboardingReq) async {
    try {
      // Make Request
      final response = await _networkService.request(
        endpointUrl.initiateOnboarding,
        RequestMethod.post,
        data: initiateOnboardingReq
            .copyWith(
              partnerCode: endpointUrl.partnerCode,
              channel: 'Mobile',
            )
            .toJson(),
      );

      // Handle the Response
      _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          _storage.saveData('requestId', res['id'] ?? '');
        },
      );
      return response.data['message'];
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
        data: verifyPhoneNumberReq
            .copyWith(
              partnerCode: endpointUrl.partnerCode,
              requestId: await _storage.readData('requestId'),
            )
            .toJson(),
      );

      // Handle the Response
      _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          _storage.saveData('requestId', res['id'] ?? '');
        },
      );
      return response.data['message'];
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
        data: createPasswordReq
            .copyWith(
              partnerCode: endpointUrl.partnerCode,
              requestId: await _storage.readData('requestId'),
            )
            .toJson(),
      );

      // Handle the Response
      _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          _storage.saveData('requestId', res['id'] ?? '');
          SharedPrefManager.email = res['modifiedBy'];
        },
      );
      return response.data['message'];
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<NewCountryModel>> getCountriesEndpoint() async {
    try {
      final response = await _networkService.request(
        endpointUrl.getCountries,
        RequestMethod.get,
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'] as List;
          final responseList =
              res.map((json) => NewCountryModel.fromJson(json)).toList();
          return responseList;
        },
      );
      return result;
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

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          SharedPrefManager.isPINSet = true;
          return response.data['message'];
        },
      );
      return result;
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

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          return response.data['message'];
        },
      );
      return result;
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

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'] as List;
          final responseList =
              res.map((json) => SecurityQuestionItem.fromJson(json)).toList();
          return responseList;
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> setSecurityQuestionEndpoint(
      SetSecurityQuestionReq setQuestionReq) async {
    try {
      final response = await _networkService.request(
        endpointUrl.setSecurityQuestion,
        RequestMethod.post,
        data: setQuestionReq.toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          return response.data['message'];
        },
      );
      return result;
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

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          return response.data['message'];
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> initiateForgotPasswordEndpoint(
      InitiateForgotPassReq initiateForgotPassReq) async {
    try {
      final response = await _networkService.request(
        endpointUrl.initiateForgotPassword,
        RequestMethod.post,
        data: initiateForgotPassReq
            .copyWith(partnerCode: endpointUrl.partnerCode)
            .toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final requestId = response.data["data"]["requestId"];
          _storage.saveData('forgotPassRequestId', requestId);
          return requestId;
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> verifyForgotPasswordOTPEndpoint(
      ForgotPasswordOtpReq forgotPasswordOtpReq) async {
    try {
      final response = await _networkService.request(
        endpointUrl.verifyForgotPasswordOtp,
        RequestMethod.post,
        data: forgotPasswordOtpReq
            .copyWith(
              requestId: await _storage.readData('forgotPassRequestId'),
            )
            .toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final requestId = response.data["data"]["requestId"];
          _storage.saveData('forgotPassRequestId', requestId);
          return requestId;
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> completeForgotPasswordEndpoint(
      CompleteForgotPassReq completeForgotPassReq) async {
    try {
      final response = await _networkService.request(
        endpointUrl.completeForgotPassword,
        RequestMethod.post,
        data: completeForgotPassReq
            .copyWith(
                partnerCode: endpointUrl.partnerCode,
                requestId: await _storage.readData(
                  'forgotPassRequestId',
                ))
            .toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final requestId = response.data["data"]["requestId"];
          _storage.saveData('forgotPassRequestId', requestId);
          return requestId;
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<KycStatus> getKycStatus() async {
    try {
      final response = await _networkService.request(
          endpointUrl.kycStatus, RequestMethod.get);

      _responseHandler.handleResponse(
          response: response.data,
          onSuccess: () {
            KycStatus.fromJson(response.data['data']);
          });
      return KycStatus.fromJson(response.data['data']);
    } catch (e) {
      throw e.toString();
    }
  }

  // Future<void> initiateKyc() async {
  //   try {
  //     final response = await _networkService.request(
  //         endpointUrl.initiateKYC, RequestMethod.upload,
  //         data: );
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }
}
