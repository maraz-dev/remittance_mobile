import 'package:remittance_mobile/core/http/http_service.dart';
import 'package:remittance_mobile/core/http/response_body_handler.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage.dart';
import 'package:remittance_mobile/core/storage/secure-storage/secure_storage.dart';
import 'package:remittance_mobile/core/utils/app_url.dart';
import 'package:remittance_mobile/data/models/requests/create_customer_req.dart';
import 'package:remittance_mobile/data/models/requests/initiate_card_funding_req.dart';
import 'package:remittance_mobile/data/models/responses/account_currencies_model.dart';
import 'package:remittance_mobile/data/models/responses/account_model.dart';
import 'package:remittance_mobile/data/models/responses/banks_model.dart';

class AccountService {
  final HttpService _networkService;
  final SecureStorageBase _storage;
  final HiveStorageBase _hivestorage;

  AccountService(
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
  Future<List<BanksModel>> getBanksEndpoint() async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseFundingUrl + endpointUrl.getBanks,
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
  Future<AccountModel> fundWithCardEndpoint(InitiateCardFundingReq req) async {
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
}
