import 'package:remittance_mobile/data/models/requests/authorize_charge_req.dart';
import 'package:remittance_mobile/data/models/requests/create_customer_req.dart';
import 'package:remittance_mobile/data/models/requests/initiate_card_funding_req.dart';
import 'package:remittance_mobile/data/models/requests/inititiate_ussd_funding_req.dart';
import 'package:remittance_mobile/data/models/responses/account_currencies_model.dart';
import 'package:remittance_mobile/data/models/responses/account_model.dart';
import 'package:remittance_mobile/data/models/responses/banks_model.dart';
import 'package:remittance_mobile/data/models/responses/card_funding_response_model.dart';
import 'package:remittance_mobile/data/models/responses/validate_card_funding_model.dart';
import 'package:remittance_mobile/data/remote/account-remote/account_service.dart';
import 'package:remittance_mobile/domain/account_repo.dart';

class AccountImpl implements AccountRepository {
  final AccountService _accountService;

  AccountImpl(this._accountService);

  @override
  Future<AccountModel> createIndividualAccountEndpoint(
          CreateCustomerAccountReq req) async =>
      await _accountService.createIndividualAccountEndpoint(req);

  @override
  Future<List<AccountCurrencies>> getAccountOpeningCurrenciesEndpoint() async =>
      await _accountService.getAccountOpeningCurrenciesEndpoint();

  @override
  Future<List<AccountModel>> getAccountsEndpoint() async =>
      await _accountService.getAccountsEndpoint();

  @override
  Future<List<BanksModel>> getBanksEndpoint() async =>
      await _accountService.getBanksEndpoint();

  @override
  Future<CardFundingResponseModel> fundWithCardEndpoint(
          InitiateCardFundingReq req) async =>
      await _accountService.fundWithCardEndpoint(req);

  @override
  Future<CardFundingResponseModel> fundWithUssdEndpoint(
          InitiateUssdFundingReq req) async =>
      await _accountService.fundWithUssdEndpoint(req);

  @override
  Future<AccountModel> getIndividualAccountsEndpoint(
          String country, String currency) async =>
      await _accountService.getIndividualAccountsEndpoint(country, currency);

  @override
  Future<String> authorizeAVSCardFunding(AvsAuthorizationReq req) async =>
      await _accountService.authorizeAVSCardFunding(req);

  @override
  Future<String> authorizePINCardFunding(PinAuthorizationReq req) async =>
      await _accountService.authorizePINCardFunding(req);

  @override
  Future<ValidateCardFundingModel> validateCardFunding(String otp) async =>
      await _accountService.validateCardFunding(otp);
}