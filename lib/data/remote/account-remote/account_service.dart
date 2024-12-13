import 'package:remittance_mobile/core/http/http_service.dart';
import 'package:remittance_mobile/core/http/response_body_handler.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage.dart';
import 'package:remittance_mobile/core/storage/secure-storage/secure_storage.dart';
import 'package:remittance_mobile/core/utils/app_url.dart';
import 'package:remittance_mobile/data/models/requests/authorize_charge_req.dart';
import 'package:remittance_mobile/data/models/requests/checkout_req.dart';
import 'package:remittance_mobile/data/models/requests/create_customer_req.dart';
import 'package:remittance_mobile/data/models/requests/fund_with_bank_transfer_req.dart';
import 'package:remittance_mobile/data/models/requests/initiate_card_funding_req.dart';
import 'package:remittance_mobile/data/models/requests/inititiate_ussd_funding_req.dart';
import 'package:remittance_mobile/data/models/requests/verify_transx_req.dart';
import 'package:remittance_mobile/data/models/responses/account_currencies_model.dart';
import 'package:remittance_mobile/data/models/responses/account_model.dart';
import 'package:remittance_mobile/data/models/responses/banks_model.dart';
import 'package:remittance_mobile/data/models/responses/card_funding_response_model.dart';
import 'package:remittance_mobile/data/models/responses/checkout_model.dart';
import 'package:remittance_mobile/data/models/responses/fund_with_bank_transfer_dto.dart';
import 'package:remittance_mobile/data/models/responses/funding_options_dto.dart';
import 'package:remittance_mobile/data/models/responses/ussd_bank_model.dart';
import 'package:remittance_mobile/data/models/responses/ussd_funding_model.dart';
import 'package:remittance_mobile/data/models/responses/validate_card_funding_model.dart';
import 'package:remittance_mobile/data/models/responses/verify_transx_model.dart';
import 'package:remittance_mobile/view/features/home/currency_account_view.dart';

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
          final responseList = res.map((json) => AccountCurrencies.fromJson(json)).toList();
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
          final responseList = res.map((json) => AccountModel.fromJson(json)).toList();
          return responseList;
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Get Account Endpoint
  Future<AccountModel> getIndividualAccountsEndpoint(String country, String currency) async {
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
  Future<AccountModel> createIndividualAccountEndpoint(CreateCustomerAccountReq req) async {
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
  Future<List<FundingOptionDto>> getFundingOptionsEndpoint(String accountNumber) async {
    try {
      final response = await _networkService.request(
        '${endpointUrl.baseFundingUrl}${endpointUrl.getFundingOptions}/$accountNumber',
        RequestMethod.get,
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'] as List;
          final responseList = res.map((json) => FundingOptionDto.fromJson(json)).toList();
          return responseList;
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
          final responseList = res.map((json) => BanksModel.fromJson(json)).toList();
          return responseList;
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Get Banks
  Future<List<BanksModel>> getMobileBanksEndpoint(String country) async {
    try {
      final response = await _networkService.request(
        '${endpointUrl.baseFundingUrl}${endpointUrl.getBanks}/$country/MobileMoney',
        RequestMethod.get,
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'] as List;
          final responseList = res.map((json) => BanksModel.fromJson(json)).toList();
          return responseList;
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Get USSD Banks
  Future<List<UssdBanksDto>> getUSSDBanksEndpoint(String vendorCode) async {
    try {
      final response = await _networkService.request(
        '${endpointUrl.baseFundingUrl}${endpointUrl.getUssdBanks}/${accountInfo.value.countryCode}/$vendorCode',
        RequestMethod.get,
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'] as List;
          final responseList = res.map((json) => UssdBanksDto.fromJson(json)).toList();
          return responseList;
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Fund with Card Endpoint
  Future<CardFundingResponseModel> fundWithCardEndpoint(InitiateCardFundingReq req) async {
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
  Future<VerifyFundingTransxModel> verifyFundingTransxEndpoint(VerifyFundingTransxReq req) async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseFundingUrl + endpointUrl.verifyTransaction,
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

  // Fund with Card Endpoint
  Future<CheckoutDto> fundWithCheckoutEndpoint(CheckoutReq req) async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseFundingUrl + endpointUrl.checkoutFunding,
        RequestMethod.post,
        data: req.toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () async {
          final res = response.data['data'];
          await _storage.saveData('fundingId', res['requestId']);
          return CheckoutDto.fromJson(res);
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Fund with USSD Endpoint
  Future<UssdFundingDto> fundWithUssdEndpoint(InitiateUssdFundingReq req) async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseFundingUrl + endpointUrl.initiateUSSDFunding,
        RequestMethod.post,
        data: req.toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () async {
          final res = response.data['data'];
          await _storage.saveData('fundingId', res['requestId']);
          return UssdFundingDto.fromJson(res);
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Fund with Bank Transfer Endpoint
  Future<FundWithBankTransferDto> fundWithBankTransferEndpoint(FundWithBankTransferReq req) async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseFundingUrl + endpointUrl.fundWithBankTransfer,
        RequestMethod.post,
        data: req.toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () async {
          final res = response.data['data'];
          await _storage.saveData('fundingId', res['requestId']);
          return FundWithBankTransferDto.fromJson(res);
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }
}
