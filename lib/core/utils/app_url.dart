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
      _environment = Environmentx.dev;
    }
  }

  /// Set Environment
  static void init(Environmentx environment) {
    _environment = environment;
  }

  String get baseURL {
    switch (_environment) {
      case Environmentx.dev:
        return devURL;
      case Environmentx.prod:
        return productionURL;
      default:
        return "";
    }
  }

  String get baseUrlTwo {
    switch (_environment) {
      case Environmentx.dev:
        return devURLTwo;
      case Environmentx.prod:
        return productionURL;
      default:
        return "";
    }
  }

  static const String devURL =
      "https://g7xnbur2kbxtmlze62vooojm5q0urryd.lambda-url.us-east-2.on.aws";
  static const String devURLTwo =
      "https://ezlxlamrm6k2mjma5gvjk5bqge0qomep.lambda-url.us-east-2.on.aws";
  static const String productionURL = "";

  // static final baseUrl =
  //     _environment == Environmentx.prod ? productionURL : devURL;

  // Partner Code
  String get partnerCode => "P00001";

  /// version
  String get version => "v1";

  // Authentication
  String get login => "/api/v1/partner/auth/Login";
  String get setPin => "/api/v1/partner/auth/SetPin";
  String get validatePin => "/api/v1/partner/auth/ValidatePin";
  String get changePassword => "/api/v1/partner/auth/ChangePassword";

  // Security Questions
  String get getSecurityQuestion =>
      "/api/v1/SecurityQuestion/GetSecurityQuestions";
  String get getUserSecurityQuestion =>
      "/api/v1/SecurityQuestion/GetUserSecurityQuestions";
  String get setSecurityQuestion =>
      "/api/v1/SecurityQuestion/SetUserSecurityQuestion";
  String get validateSecurityQuestion =>
      "/api/v1/SecurityQuestion/ValidateUserSecurityQuestion";

  // Onboarding
  String get initiateOnboarding =>
      "/api/v1/partner/customer/onboarding/InitiateIndividualOnboarding";
  String get verifyPhoneNumber =>
      "/api/v1/partner/customer/onboarding/VerifyPhoneNumber";
  String get createPassword =>
      "/api/v1/partner/customer/onboarding/CreatePassword";
  String get getCountries => "/api/v1/Utility/countries?includeFlagImage=true";
  String get initiateForgotPassword =>
      "/api/v1/partner/customer/onboarding/InitiateForgotPassword";
  String get verifyForgotPasswordOtp =>
      "/api/v1/partner/customer/onboarding/VerifyOtp";
  String get completeForgotPassword =>
      "/api/v1/partner/customer/onboarding/CompleteForgotPassword";

  // KYC
  String get kycStatus => "/api/v1/kyc/customer/GetStatus";
  String get initiateKYC => "/api/v1/kyc/customer/Initiate";
  String get resubmitBvnOrSsn => "/api/v1/kyc/customer/ResubmitBvnOrSsn";
  String get resubmitMeansOfId => "/api/v1/kyc/customer/ResubmitMeansOfId";
  String get resubmitProofOfAddress =>
      "/api/v1/kyc/customer/ResubmitProofOfAddress";

  // Refresh Token
  String get refresh => "/$version/auth/refresh";

  // Auth Token
  String get token => "token";
}

enum Environment { dev, prod }
