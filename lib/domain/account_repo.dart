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

abstract class AccountRepository {
  Future<List<AccountCurrencies>> getAccountOpeningCurrenciesEndpoint();
  Future<List<AccountModel>> getAccountsEndpoint();
  Future<AccountModel> getIndividualAccountsEndpoint(String country, String currency);
  Future<AccountModel> createIndividualAccountEndpoint(CreateCustomerAccountReq req);
  Future<List<FundingOptionDto>> getFundingOptionsEndpoint(String accountNumber);
  Future<List<BanksModel>> getBanksEndpoint(String country);
  Future<List<BanksModel>> getMobileBanksEndpoint(String country);
  Future<List<UssdBanksDto>> getUSSDBanksEndpoint(String vendorCode);
  Future<CheckoutDto> fundWithCheckoutEndpoint(CheckoutReq req);
  Future<UssdFundingDto> fundWithUssdEndpoint(InitiateUssdFundingReq req);
  Future<CardFundingResponseModel> fundWithCardEndpoint(InitiateCardFundingReq req);
  Future<String> authorizePINCardFunding(PinAuthorizationReq req);
  Future<String> authorizeAVSCardFunding(AvsAuthorizationReq req);
  Future<ValidateCardFundingModel> validateCardFunding(String otp);
  Future<VerifyFundingTransxModel> verifyFundingTransxEndpoint(VerifyFundingTransxReq req);
  Future<FundWithBankTransferDto> fundWithBankTransferEndpoint(FundWithBankTransferReq req);
}
