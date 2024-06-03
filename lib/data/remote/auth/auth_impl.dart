import 'package:remittance_mobile/data/models/requests/create_password_req.dart';
import 'package:remittance_mobile/data/models/requests/initiate_onboarding_req.dart';
import 'package:remittance_mobile/data/models/requests/login_req.dart';
import 'package:remittance_mobile/data/models/requests/security_questions_req.dart';
import 'package:remittance_mobile/data/models/requests/set_pin_req.dart';
import 'package:remittance_mobile/data/models/requests/set_security_question_req.dart';
import 'package:remittance_mobile/data/models/requests/verify_phone_number_req.dart';
import 'package:remittance_mobile/data/models/responses/new_country_model.dart';
import 'package:remittance_mobile/data/models/responses/security_question.dart';
import 'package:remittance_mobile/data/remote/auth/auth_service.dart';

abstract class AuthRepository {
  Future<String> initiateOnboardingMethod(
      InitiateOnboardingReq initiateOnboardingReq);
  Future<String> loginEndpoint(LoginReq loginReq);
  Future<String> verifyPhoneNo(VerifyPhoneNumberReq verifyPhoneNumberReq);
  Future<String> createPassword(CreatePasswordReq createPasswordReq);
  Future<List<NewCountryModel>> getCountries();
  Future<String> setPinEndpoint(SetPinReq setPinReq);
  Future<String> validatePinEndpoint(String pin);
  Future<List<SecurityQuestionItem>> getSecurityQuestionEndpoint();
  Future<String> setSecurityQuestionEndpoint(
      SetSecurityQuestionReq setQuestionReq);
  Future<String> validateSecurityQuestionEndpoint(
      SecurityQuestionReq securityQuestionReq);
}

class AuthImpl implements AuthRepository {
  final AuthService _authService;

  AuthImpl(this._authService);

  @override
  Future<String> initiateOnboardingMethod(
          InitiateOnboardingReq initiateOnboardingReq) async =>
      await _authService.initiateOnboardingEndpoint(initiateOnboardingReq);

  @override
  Future<String> loginEndpoint(LoginReq loginReq) async =>
      await _authService.loginEndpoint(loginReq);

  @override
  Future<String> verifyPhoneNo(
          VerifyPhoneNumberReq verifyPhoneNumberReq) async =>
      await _authService.verifyPhoneNoEndpoint(verifyPhoneNumberReq);

  @override
  Future<String> createPassword(CreatePasswordReq createPasswordReq) async =>
      await _authService.createPasswordEndpoint(createPasswordReq);

  @override
  Future<List<NewCountryModel>> getCountries() async =>
      await _authService.getCountriesEndpoint();

  @override
  Future<List<SecurityQuestionItem>> getSecurityQuestionEndpoint() async =>
      await _authService.getSecurityQuestionEndpoint();

  @override
  Future<String> setPinEndpoint(SetPinReq setPinReq) async =>
      await _authService.setPinEndpoint(setPinReq);

  @override
  Future<String> setSecurityQuestionEndpoint(
          SetSecurityQuestionReq setQuestionReq) async =>
      await _authService.setSecurityQuestionEndpoint(setQuestionReq);

  @override
  Future<String> validatePinEndpoint(String pin) async =>
      await _authService.validatePinEndpoint(pin);

  @override
  Future<String> validateSecurityQuestionEndpoint(
      SecurityQuestionReq securityQuestionReq) async {
    return await _authService
        .validateSecurityQuestionEndpoint(securityQuestionReq);
  }
}
