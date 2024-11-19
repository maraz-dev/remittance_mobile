import 'package:config/Config.dart';
import 'package:remittance_mobile/core/third-party/environment.dart';
import 'package:remittance_mobile/core/utils/logger.dart';

enum UrlNo { urlOne, urlTwo }

class ApiEndpoints {
  static final ApiEndpoints _instance = ApiEndpoints._privateConstructor();
  static ApiEndpoints get instance => _instance;
  static Environmentx? _environment;

  ApiEndpoints._privateConstructor() {
    if (_environment == null) {
      logger.info(
        "${"ApiEndpoints----->"} ,Call init to set the environment, environment set to dev by default",
      );
      _environment = Environmentx.staging;
    }
  }

  /// Set Environment
  static void init(Environmentx environment) {
    _environment = environment;
  }

  String get baseUserURL {
    switch (_environment) {
      case Environmentx.staging:
        return devUserURL;
      case Environmentx.prod:
        return prodUserURL;
      default:
        return "";
    }
  }

  String get baseAccountUrl {
    switch (_environment) {
      case Environmentx.staging:
        return devAccountURL;
      case Environmentx.prod:
        return prodAccountURL;
      default:
        return "";
    }
  }

  String get baseFundingUrl {
    switch (_environment) {
      case Environmentx.staging:
        return devFundingURL;
      case Environmentx.prod:
        return prodFundingURL;
      default:
        return "";
    }
  }

  static const String devUserURL = "https://staging.apis.borderpal.co/users";
  static const String prodUserURL = "https://api.borderpal.co/users";

  static const String devAccountURL = "https://staging.apis.borderpal.co/accounts";
  static const String prodAccountURL = "https://api.borderpal.co/accounts";

  static const String devFundingURL = "https://staging.apis.borderpal.co/fundstransfer";
  static const String prodFundingURL = "https://api.borderpal.co/fundstransfer";

  static const String productionURL = "";

  // static final baseUrl =
  //     _environment == Environmentx.prod ? productionURL : devURL;

  // Partner Code
  String get partnerCode => APP_PARTNER_CODE;

  /// version
  String get version => "v1";

  // Authentication
  String get login => "/api/v1/auth/customer/Login";
  String get setPin => "/api/v1/auth/customer/SetPin";
  String get validatePin => "/api/v1/auth/customer/ValidatePin";
  String get changePassword => "/api/v1/auth/customer/ChangePassword";

  // Security Questions
  String get getSecurityQuestion => "/api/v1/SecurityQuestion/GetSecurityQuestions";
  String get getUserSecurityQuestion => "/api/v1/SecurityQuestion/GetUserSecurityQuestions";
  String get setSecurityQuestion => "/api/v1/SecurityQuestion/SetUserSecurityQuestion";
  String get initiateValidateDevice => "/api/v1/device/initiate";
  String get validateSecurityQuestion => "/api/v1/device/security/validate";

  // Onboarding
  String get initiateOnboarding =>
      "/api/v1/partner/customer/onboarding/InitiateIndividualOnboarding";
  String get verifyPhoneNumber => "/api/v1/partner/customer/onboarding/VerifyPhoneNumber";
  String get createPassword => "/api/v1/partner/customer/onboarding/CreatePassword";
  String get resendOtpViaEmail => "/api/v1/partner/customer/onboarding/ResendOtpViaEmail";
  String get getCountries => "/api/v1/Utility/countries?includeFlagImage=true";
  String get initiateForgotPassword => "/api/v1/partner/customer/onboarding/InitiateForgotPassword";
  String get verifyForgotPasswordOtp => "/api/v1/partner/customer/onboarding/VerifyOtp";
  String get completeForgotPassword => "/api/v1/partner/customer/onboarding/CompleteForgotPassword";

  // KYC
  String get kycStatus => "/api/v1/kyc/customer/GetStatus";
  String get initiateKYC => "/api/v1/kyc/customer/Initiate";
  String get resubmitBvnOrSsn => "/api/v1/kyc/customer/ResubmitBvnOrSsn";
  String get resubmitMeansOfId => "/api/v1/kyc/customer/ResubmitMeansOfId";
  String get resubmitProofOfAddress => "/api/v1/kyc/customer/ResubmitProofOfAddress";
  String get getIdDocumentsTypes => "/api/v1/internal/idDocumentTypes";
  String get getProofOfAddressTypes => "/api/v1/internal/proofOfAddressTypes";

  // Accounts
  String get getAccounts => "/api/v1/accounts/customer/GetAccounts";
  String get getAccountsCurrencies => "/api/v1/account-opening/currencies";
  String get createIndividualAccount => "/api/v1/accounts/customer/Individual/CreateNewAccount";

  // Funding
  String get getBanks => "/api/v1/bank";
  String get getUssdBanks => '/api/v1/bank/ussd';
  String get getFundingOptions => '/api/v1/funding/customer';
  String get checkoutFunding => "/api/v1/funding/flutterwave/customer/checkout/initiate";
  String get initiateCardFunding => "/api/v1/funding/flutterwave/customer/card/initiate";
  String get validateCardFunding => "/api/v1/funding/flutterwave/card/validate";
  String get authorizeCardFunding => "/api/v1/funding/flutterwave/card/authorize";
  String get initiateUSSDFunding => "/api/v1/funding/flutterwave/customer/ussd/initiate";
  String get verifyTransaction => "/api/v1/funding/flutterwave/charge/verify";

  // Send Money
  String get getCorridors => "/api/v1/sendmoney/corridors/ST000015";
  String get sendToBank => "/api/v1/sendmoney/Bank";
  String get validateAccountNumber => "/api/v1/sendmoney/validateAccountNumber";
  String get sendToMobileMoney => "/api/v1/sendmoney/MobileMoney";
  String get sendToInAppUser => "/api/v1/sendmoney/toInAppUser";
  String get sendCharge => "/api/v1/sendmoney/charge";
  String get getBeneficiaries => "/api/v1/Beneficiary";
  String get addNewBeneficiaries => "/api/v1/Beneficiary";

  // Transaction
  String get getCustomerTransactions => "/api/v1/transaction/GetCustomerTransactions";
  String get getTransactionDetails => "/api/v1/transaction/GetTransactionDetail";

  // Refresh Token
  String get refresh => "/$version/auth/refresh";

  // Auth Token
  String get token => "token";
}

enum Environment { dev, prod }
