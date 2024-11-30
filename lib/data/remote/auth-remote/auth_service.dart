import 'package:remittance_mobile/core/http/http_service.dart';
import 'package:remittance_mobile/core/http/response_body_handler.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage_service.dart';
import 'package:remittance_mobile/core/storage/secure-storage/secure_storage.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';
import 'package:remittance_mobile/core/utils/app_url.dart';
import 'package:remittance_mobile/core/utils/constants.dart';
import 'package:remittance_mobile/core/utils/device_details.dart';
import 'package:remittance_mobile/core/utils/get_ip_address.dart';
import 'package:remittance_mobile/core/utils/location_services.dart';
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
import 'package:remittance_mobile/data/models/responses/initiate_validate_device_res.dart';
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

  Future<bool> loginEndpoint(LoginReq loginReq) async {
    // Device Details Variable
    String? deviceType, deviceToken, ipAddress, latitude, longitude, location;

    try {
      // Get Device Details
      await getDeviceDetails().then((value) {
        deviceType = value[0];
        deviceToken = value[1];
      });

      // Get Device IP Address
      await getDeviceIP().then((value) {
        ipAddress = value;
      });

      // Get Location
      await determineDeviceLocation().then((value) async {
        latitude = value.latitude.toString();
        longitude = value.longitude.toString();
        location = await getLocationAddress(value.latitude, value.longitude);
      });

      // Make Request
      final response = await _networkService.request(
        endpointUrl.login,
        RequestMethod.post,
        data: loginReq
            .copyWith(
              partnerCode: endpointUrl.partnerCode,
              channel: "Mobile",
              deviceType: deviceType,
              deviceToken: deviceToken,
              ipAddress: ipAddress,
              latitude: latitude,
              longitude: longitude,
              location: location,
            )
            .toJson(),
      );

      // Handle the Response
      _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () async {
          final res = response.data['data'];
          SharedPrefManager.userId = res['userId'];
          SharedPrefManager.email = res['email'];
          SharedPrefManager.isNewLogin = res['isNewLogin'];
          SharedPrefManager.isPINSet = res['isPINSet'];
          SharedPrefManager.isKycComplete = res['isKycComplete'];
          SharedPrefManager.isSecurityQuestionSet = res['isSecurityQuestionSet'];
          SharedPrefManager.onboardingRequestId = res['onboardingRequestId'];
          SharedPrefManager.firstName = res['firstName'];
          SharedPrefManager.lastName = res['lastName'];

          await _storage.saveData(PrefKeys.token, res['token'] ?? '');
          await _hivestorage.set(StorageKey.userProfile.name, res);

          // Save the Password for Biometrics Login
          await _storage.saveData(PrefKeys.password, loginReq.password ?? "");
        },
      );
      return response.data['data']['isSecurityQuestionSet'];
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> initiateOnboardingEndpoint(InitiateOnboardingReq initiateOnboardingReq) async {
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
        onSuccess: () async {
          final res = response.data['data'];
          await _storage.saveData(PrefKeys.requestId, res['id'] ?? '');
        },
      );
      return response.data['message'];
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> verifyPhoneNoEndpoint(VerifyPhoneNumberReq verifyPhoneNumberReq) async {
    try {
      final response = await _networkService.request(
        endpointUrl.verifyPhoneNumber,
        RequestMethod.post,
        data: verifyPhoneNumberReq
            .copyWith(
              partnerCode: endpointUrl.partnerCode,
              requestId: await _storage.readData(PrefKeys.requestId),
            )
            .toJson(),
      );

      // Handle the Response
      _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () async {
          final res = response.data['data'];
          await _storage.saveData(PrefKeys.requestId, res['id'] ?? '');
        },
      );
      return response.data['message'];
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> resendViaEmailEndpoint() async {
    try {
      final requestId = await _storage.readData(PrefKeys.requestId);

      final response = await _networkService.request(
        "${endpointUrl.resendOtpViaEmail}?requestId=$requestId",
        RequestMethod.post,
      );

      // Handle the Response
      _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          response.data['data'];
        },
      );
      return response.data['message'];
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> createPasswordEndpoint(CreatePasswordReq createPasswordReq) async {
    String? deviceType, deviceToken, latitude, longitude, location, ipAddress;
    bool? isPlatformAndroid;

    try {
      // Get Device Details
      await getDeviceDetails().then((value) {
        deviceType = value[0];
        deviceToken = value[1];
        isPlatformAndroid = value[2];
      });

      // Get Location
      await determineDeviceLocation().then((value) async {
        latitude = value.latitude.toString();
        longitude = value.longitude.toString();
        location = await getLocationAddress(value.latitude, value.longitude);
      });

      // Get Device IP Address
      await getDeviceIP().then((value) {
        ipAddress = value;
      });

      final response = await _networkService.request(
        endpointUrl.createPassword,
        RequestMethod.post,
        data: createPasswordReq
            .copyWith(
              partnerCode: endpointUrl.partnerCode,
              requestId: await _storage.readData(PrefKeys.requestId),
              clientChannel: "Mobile",
              deviceType: deviceType,
              deviceId: deviceToken,
              deviceToken: deviceToken,
              ipAddress: ipAddress,
              isAndroidDevice: isPlatformAndroid,
              location: location,
              latitude: latitude,
              longitude: longitude,
            )
            .toJson(),
      );

      // Handle the Response
      _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () async {
          final res = response.data['data'];
          await _storage.saveData(PrefKeys.requestId, res['id'] ?? '');
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
          final responseList = res.map((json) => NewCountryModel.fromJson(json)).toList();
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
          final responseList = res.map((json) => SecurityQuestionItem.fromJson(json)).toList();
          return responseList;
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> setSecurityQuestionEndpoint(SetSecurityQuestionReq setQuestionReq) async {
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

  Future<InitiateValidateDeviceDto> initiateValidateDeviceEndpoint(String email) async {
    try {
      // Encode the Email to handle cases with special character
      String encodedEmail = Uri.encodeComponent(email);

      final response = await _networkService.request(
        "${endpointUrl.initiateValidateDevice}?partnerCode=${endpointUrl.partnerCode}&email=$encodedEmail",
        RequestMethod.get,
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          return InitiateValidateDeviceDto.fromJson(res);
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> validateSecurityQuestionEndpoint(SecurityQuestionReq securityQuestionReq) async {
    String? deviceType, deviceToken, latitude, longitude, location, ipAddress;
    bool? isPlatformAndroid;

    try {
      // Get Device Details
      await getDeviceDetails().then((value) {
        deviceType = value[0];
        deviceToken = value[1];
        isPlatformAndroid = value[2];
      });

      // Get Location
      await determineDeviceLocation().then((value) async {
        latitude = value.latitude.toString();
        longitude = value.longitude.toString();
        location = await getLocationAddress(value.latitude, value.longitude);
      });

      // Get Device IP Address
      await getDeviceIP().then((value) {
        ipAddress = value;
      });

      final response = await _networkService.request(
        endpointUrl.validateSecurityQuestion,
        RequestMethod.post,
        data: securityQuestionReq
            .copyWith(
              partnerCode: endpointUrl.partnerCode,
              deviceId: deviceToken,
              deviceToken: deviceToken,
              deviceType: deviceType,
              ipAddress: ipAddress,
              isAndroidDevice: isPlatformAndroid,
              clientChannel: 'Mobile',
              latitude: latitude,
              longitude: longitude,
              location: location,
            )
            .toJson(),
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

  Future<bool> initiateForgotPasswordEndpoint(InitiateForgotPassReq initiateForgotPassReq) async {
    try {
      final response = await _networkService.request(
        endpointUrl.initiateForgotPassword,
        RequestMethod.post,
        data: initiateForgotPassReq.copyWith(partnerCode: endpointUrl.partnerCode).toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () async {
          final requestId = response.data["data"];
          //await _storage.saveData('forgotPassRequestId', requestId);
          return requestId as bool;
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> verifyForgotPasswordOTPEndpoint(ForgotPasswordOtpReq forgotPasswordOtpReq) async {
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
        onSuccess: () async {
          final requestId = response.data["data"]["requestId"];
          await _storage.saveData('forgotPassRequestId', requestId);
          return requestId;
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> completeForgotPasswordEndpoint(CompleteForgotPassReq completeForgotPassReq) async {
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
        onSuccess: () async {
          final requestId = response.data["data"]["requestId"];
          await _storage.saveData('forgotPassRequestId', requestId);
          return requestId;
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }
}
