import 'package:remittance_mobile/data/models/requests/authorize_charge_req.dart';
import 'package:remittance_mobile/data/models/requests/create_customer_req.dart';
import 'package:remittance_mobile/data/models/requests/initiate_card_funding_req.dart';
import 'package:remittance_mobile/data/models/requests/inititiate_ussd_funding_req.dart';
import 'package:remittance_mobile/data/models/responses/account_currencies_model.dart';
import 'package:remittance_mobile/data/models/responses/account_model.dart';
import 'package:remittance_mobile/data/models/responses/banks_model.dart';
import 'package:remittance_mobile/data/models/responses/card_funding_response_model.dart';
import 'package:remittance_mobile/data/models/responses/validate_card_funding_model.dart';

abstract class AccountRepository {
  Future<List<AccountCurrencies>> getAccountOpeningCurrenciesEndpoint();
  Future<List<AccountModel>> getAccountsEndpoint();
  Future<AccountModel> getIndividualAccountsEndpoint(
      String country, String currency);
  Future<AccountModel> createIndividualAccountEndpoint(
      CreateCustomerAccountReq req);
  Future<List<BanksModel>> getBanksEndpoint();
  Future<CardFundingResponseModel> fundWithUssdEndpoint(
      InitiateUssdFundingReq req);
  Future<CardFundingResponseModel> fundWithCardEndpoint(
      InitiateCardFundingReq req);
  Future<String> authorizePINCardFunding(PinAuthorizationReq req);
  Future<String> authorizeAVSCardFunding(AvsAuthorizationReq req);
  Future<ValidateCardFundingModel> validateCardFunding(String otp);
}
