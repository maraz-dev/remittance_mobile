import 'package:remittance_mobile/core/http/http_service.dart';
import 'package:remittance_mobile/core/http/response_body_handler.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage.dart';
import 'package:remittance_mobile/core/storage/secure-storage/secure_storage.dart';
import 'package:remittance_mobile/core/utils/app_url.dart';
import 'package:remittance_mobile/core/utils/device_details.dart';
import 'package:remittance_mobile/core/utils/get_ip_address.dart';
import 'package:remittance_mobile/core/utils/location_services.dart';
import 'package:remittance_mobile/data/models/requests/authorize_charge_req.dart';
import 'package:remittance_mobile/data/models/requests/create_customer_req.dart';
import 'package:remittance_mobile/data/models/requests/initiate_card_funding_req.dart';
import 'package:remittance_mobile/data/models/requests/inititiate_ussd_funding_req.dart';
import 'package:remittance_mobile/data/models/requests/send_money_charge.dart';
import 'package:remittance_mobile/data/models/requests/send_money_to_bank_req.dart';
import 'package:remittance_mobile/data/models/requests/send_money_to_mobile_money.dart';
import 'package:remittance_mobile/data/models/requests/verify_transx_req.dart';
import 'package:remittance_mobile/data/models/responses/account_currencies_model.dart';
import 'package:remittance_mobile/data/models/responses/account_model.dart';
import 'package:remittance_mobile/data/models/responses/banks_model.dart';
import 'package:remittance_mobile/data/models/responses/card_funding_response_model.dart';
import 'package:remittance_mobile/data/models/responses/send_charge_response.dart';
import 'package:remittance_mobile/data/models/responses/send_money_response.dart';
import 'package:remittance_mobile/data/models/responses/validate_card_funding_model.dart';
import 'package:remittance_mobile/data/models/responses/verify_transx_model.dart';

class AccountService {
  final HttpService _networkService;
  final SecureStorageBase _storage;

  AccountService(
      {required HttpService networkService,
      required SecureStorageBase storage,
      required HiveStorageBase hivestorage})
      : _networkService = networkService,
        _storage = storage;

  // Endpoint URL Instance
  final endpointUrl = ApiEndpoints.instance;

  // Class to Handle API Response
  final ResponseHandler _responseHandler = ResponseHandler();

  // Get Currencies to Open an Account
  Future<List<AccountCurrencies>> getAccountOpeningCurrenciesEndpoint() async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseAccountUrl + endpointUrl.getAccountsCurrencies,
        RequestMethod.get,
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'] as List;
          final responseList =
              res.map((json) => AccountCurrencies.fromJson(json)).toList();
          return responseList;
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Get Account Endpoint
  Future<List<AccountModel>> getAccountsEndpoint() async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseAccountUrl + endpointUrl.getAccounts,
        RequestMethod.get,
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'] as List;
          final responseList =
              res.map((json) => AccountModel.fromJson(json)).toList();
          return responseList;
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Get Account Endpoint
  Future<AccountModel> getIndividualAccountsEndpoint(
      String country, String currency) async {
    try {
      final response = await _networkService.request(
        "${endpointUrl.baseAccountUrl}${endpointUrl.getAccounts}?countryCode=$country&currencyCode=$currency",
        RequestMethod.get,
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'] as List;
          return AccountModel.fromJson(res.first);
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Create Individual Accounts
  Future<AccountModel> createIndividualAccountEndpoint(
      CreateCustomerAccountReq req) async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseAccountUrl + endpointUrl.createIndividualAccount,
        RequestMethod.post,
        data: req.toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          return AccountModel.fromJson(res);
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Get Banks
  Future<List<BanksModel>> getBanksEndpoint(String country) async {
    try {
      final response = await _networkService.request(
        '${endpointUrl.baseFundingUrl}${endpointUrl.getBanks}/$country/bank',
        RequestMethod.get,
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'] as List;
          final responseList =
              res.map((json) => BanksModel.fromJson(json)).toList();
          return responseList;
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Fund with Card Endpoint
  Future<CardFundingResponseModel> fundWithCardEndpoint(
      InitiateCardFundingReq req) async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseFundingUrl + endpointUrl.initiateCardFunding,
        RequestMethod.post,
        data: req.toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () async {
          final res = response.data['data'];
          await _storage.saveData('fundingId', res['requestId']);
          return CardFundingResponseModel.fromJson(res);
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> authorizePINCardFunding(PinAuthorizationReq req) async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseFundingUrl + endpointUrl.authorizeCardFunding,
        RequestMethod.post,
        data: req
            .copyWith(
              requestId: await _storage.readData('fundingId'),
            )
            .toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () async {
          final res = response.data['data'];
          return res['message'] as String;
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> authorizeAVSCardFunding(AvsAuthorizationReq req) async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseFundingUrl + endpointUrl.authorizeCardFunding,
        RequestMethod.post,
        data: req
            .copyWith(
              requestId: await _storage.readData('fundingId'),
            )
            .toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () async {
          final res = response.data['data'];
          return res['message'] as String;
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ValidateCardFundingModel> validateCardFunding(String otp) async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseFundingUrl + endpointUrl.validateCardFunding,
        RequestMethod.post,
        data: {
          "otp": otp,
          "requestId": await _storage.readData('fundingId'),
        },
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          return ValidateCardFundingModel.fromJson(res);
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Verify Transaction
  Future<VerifyFundingTransxModel> verifyFundingTransxEndpoint(
      VerifyFundingTransxReq req) async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseFundingUrl + endpointUrl.verifyTransaction,
        RequestMethod.post,
        data: req.toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          return VerifyFundingTransxModel.fromJson(res);
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Fund with USSD Endpoint
  Future<CardFundingResponseModel> fundWithUssdEndpoint(
      InitiateUssdFundingReq req) async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseFundingUrl + endpointUrl.initiateUSSDFunding,
        RequestMethod.post,
        data: req.toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          return CardFundingResponseModel.fromJson(res);
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Send to Bank
  Future<SendMoneyResponse> sendMoneyToBankEndpoint(SendToBankReq req) async {
    String? deviceToken, ipAddress, latitude, longitude;

    try {
      await getDeviceDetails().then((value) {
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
      });

      final response = await _networkService.request(
        endpointUrl.baseFundingUrl + endpointUrl.sendToBank,
        RequestMethod.post,
        data: req
            .copyWith(
              deviceToken: deviceToken,
              longitude: longitude,
              latitude: latitude,
              ipAddress: ipAddress,
            )
            .toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          return SendMoneyResponse.fromJson(res);
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Send to Mobile Money
  Future<SendMoneyResponse> sendMoneyToMobileMoneyEndpoint(
      SendToMobileMoneyReq req) async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseFundingUrl + endpointUrl.sendToMobileMoney,
        RequestMethod.post,
        data: req.toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          return SendMoneyResponse.fromJson(res);
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Send to ErrandPay User
  Future<SendMoneyResponse> sendMoneyToInAppUserEndpoint(
      SendToMobileMoneyReq req) async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseFundingUrl + endpointUrl.sendToInAppUser,
        RequestMethod.post,
        data: req.toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          return SendMoneyResponse.fromJson(res);
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Send to Mobile Money
  Future<SendChargeResponse> sendMoneyChargeEndpoint(SendChargeReq req) async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseFundingUrl + endpointUrl.sendCharge,
        RequestMethod.post,
        data: req
            .copyWith(
              channel: 'Mobile',
            )
            .toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          return SendMoneyResponse.fromJson(res);
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }
}
