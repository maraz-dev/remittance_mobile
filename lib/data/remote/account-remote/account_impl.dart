import 'package:remittance_mobile/data/models/requests/authorize_charge_req.dart';
import 'package:remittance_mobile/data/models/requests/checkout_req.dart';
import 'package:remittance_mobile/data/models/requests/create_customer_req.dart';
import 'package:remittance_mobile/data/models/requests/initiate_card_funding_req.dart';
import 'package:remittance_mobile/data/models/requests/inititiate_ussd_funding_req.dart';
import 'package:remittance_mobile/data/models/requests/verify_transx_req.dart';
import 'package:remittance_mobile/data/models/responses/account_currencies_model.dart';
import 'package:remittance_mobile/data/models/responses/account_model.dart';
import 'package:remittance_mobile/data/models/responses/banks_model.dart';
import 'package:remittance_mobile/data/models/responses/card_funding_response_model.dart';
import 'package:remittance_mobile/data/models/responses/checkout_model.dart';
import 'package:remittance_mobile/data/models/responses/ussd_bank_model.dart';
import 'package:remittance_mobile/data/models/responses/ussd_funding_model.dart';
import 'package:remittance_mobile/data/models/responses/validate_card_funding_model.dart';
import 'package:remittance_mobile/data/models/responses/verify_transx_model.dart';
import 'package:remittance_mobile/data/remote/account-remote/account_service.dart';
import 'package:remittance_mobile/domain/account_repo.dart';

class AccountImpl implements AccountRepository {
  final AccountService _accountService;

  AccountImpl(this._accountService);

  @override
  Future<AccountModel> createIndividualAccountEndpoint(CreateCustomerAccountReq req) async =>
      await _accountService.createIndividualAccountEndpoint(req);

  @override
  Future<List<AccountCurrencies>> getAccountOpeningCurrenciesEndpoint() async =>
      await _accountService.getAccountOpeningCurrenciesEndpoint();

  @override
  Future<List<AccountModel>> getAccountsEndpoint() async =>
      await _accountService.getAccountsEndpoint();

  @override
  Future<List<BanksModel>> getBanksEndpoint(String country) async =>
      await _accountService.getBanksEndpoint(country);

  @override
  Future<CardFundingResponseModel> fundWithCardEndpoint(InitiateCardFundingReq req) async =>
      await _accountService.fundWithCardEndpoint(req);

  @override
  Future<UssdFundingDto> fundWithUssdEndpoint(InitiateUssdFundingReq req) async =>
      await _accountService.fundWithUssdEndpoint(req);

  @override
  Future<AccountModel> getIndividualAccountsEndpoint(String country, String currency) async =>
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

  @override
  Future<VerifyFundingTransxModel> verifyFundingTransxEndpoint(VerifyFundingTransxReq req) async =>
      await _accountService.verifyFundingTransxEndpoint(req);

  @override
  Future<CheckoutDto> fundWithCheckoutEndpoint(CheckoutReq req) async =>
      await _accountService.fundWithCheckoutEndpoint(req);

  @override
  Future<List<UssdBanksDto>> getUSSDBanksEndpoint(String vendorCode) async {
    return await _accountService.getUSSDBanksEndpoint(vendorCode);
  }
}
