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
import 'package:remittance_mobile/data/models/responses/corridor_response.dart';
import 'package:remittance_mobile/data/models/responses/send_charge_response.dart';
import 'package:remittance_mobile/data/models/responses/send_money_response.dart';
import 'package:remittance_mobile/data/models/responses/validate_card_funding_model.dart';
import 'package:remittance_mobile/data/models/responses/verify_transx_model.dart';

abstract class AccountRepository {
  Future<List<AccountCurrencies>> getAccountOpeningCurrenciesEndpoint();
  Future<List<AccountModel>> getAccountsEndpoint();
  Future<AccountModel> getIndividualAccountsEndpoint(
      String country, String currency);
  Future<AccountModel> createIndividualAccountEndpoint(
      CreateCustomerAccountReq req);
  Future<List<BanksModel>> getBanksEndpoint(String country);
  Future<CardFundingResponseModel> fundWithUssdEndpoint(
      InitiateUssdFundingReq req);
  Future<CardFundingResponseModel> fundWithCardEndpoint(
      InitiateCardFundingReq req);
  Future<String> authorizePINCardFunding(PinAuthorizationReq req);
  Future<String> authorizeAVSCardFunding(AvsAuthorizationReq req);
  Future<ValidateCardFundingModel> validateCardFunding(String otp);
  Future<VerifyFundingTransxModel> verifyFundingTransxEndpoint(
      VerifyFundingTransxReq req);
  Future<List<CorridorsResponse>> getCorridorsEndpoint();
  Future<SendMoneyResponse> sendMoneyToBankEndpoint(SendToBankReq req);
  Future<SendMoneyResponse> sendMoneyToMobileMoneyEndpoint(
      SendToMobileMoneyReq req);
  Future<SendMoneyResponse> sendMoneyToInAppUserEndpoint(
      SendToMobileMoneyReq req);
  Future<SendChargeResponse> sendMoneyChargeEndpoint(SendChargeReq req);
}
