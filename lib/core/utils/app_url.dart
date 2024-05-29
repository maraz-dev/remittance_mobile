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

  static const String devURL =
      "https://g7xnbur2kbxtmlze62vooojm5q0urryd.lambda-url.us-east-2.on.aws";
  static const String devURLTwo =
      "https://ezlxlamrm6k2mjma5gvjk5bqge0qomep.lambda-url.us-east-2.on.aws";
  static const String productionURL = "";

  static final baseUrl =
      _environment == Environmentx.prod ? productionURL : devURLTwo;

  ///Partner Code
  String get partnerCode => "P00001";

  /// version
  String get version => "v1";

  /// Authentication
  String get login => "/api/v1/partner/auth/Login";

  /// Onboarding
  String get initiateOnboarding =>
      "/api/v1/partner/customer/onboarding/InitiateIndividualOnboarding";
  String get verifyPhoneNumber =>
      "/api/v1/partner/customer/onboarding/VerifyPhoneNumber";
  String get createPassword =>
      "/api/v1/partner/customer/onboarding/CreatePassword";
  String get getCountries => "/api/v1/Utility/countries?includeFlagImage=true";

  ///Refresh Token
  String get refresh => "/$version/auth/refresh";

  /// Auth Token
  String get token => "token";
}

enum Environment { dev, prod }
