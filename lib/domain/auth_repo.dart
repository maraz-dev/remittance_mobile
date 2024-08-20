import 'package:remittance_mobile/data/models/requests/complete_forgot_password_req.dart';
import 'package:remittance_mobile/data/models/requests/create_password_req.dart';
import 'package:remittance_mobile/data/models/requests/forgot_pass_verify_otp.dart';
import 'package:remittance_mobile/data/models/requests/initiate_forgot_password_req.dart';
import 'package:remittance_mobile/data/models/requests/initiate_onboarding_req.dart';
import 'package:remittance_mobile/data/models/requests/login_req.dart';
import 'package:remittance_mobile/data/models/requests/security_questions_req.dart';
import 'package:remittance_mobile/data/models/requests/set_pin_req.dart';
import 'package:remittance_mobile/data/models/requests/set_security_question_req.dart';
import 'package:remittance_mobile/data/models/requests/verify_phone_number_req.dart';
import 'package:remittance_mobile/data/models/responses/new_country_model.dart';
import 'package:remittance_mobile/data/models/responses/security_question_item_model.dart';

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
  Future<String> initiateForgotPasswordEndpoint(
      InitiateForgotPassReq initiateForgotPassReq);
  Future<String> verifyForgotPasswordOTPEndpoint(
      ForgotPasswordOtpReq forgotPasswordOtpReq);
  Future<String> completeForgotPasswordEndpoint(
      CompleteForgotPassReq completeForgotPassReq);
  Future<String> resendViaEmailEndpoint();
}
