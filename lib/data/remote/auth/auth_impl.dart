import 'package:remittance_mobile/data/models/requests/create_password_req.dart';
import 'package:remittance_mobile/data/models/requests/initiate_onboarding_req.dart';
import 'package:remittance_mobile/data/models/requests/login_req.dart';
import 'package:remittance_mobile/data/models/requests/verify_phone_number_req.dart';
import 'package:remittance_mobile/data/models/responses/new_country_model.dart';
import 'package:remittance_mobile/data/remote/auth/auth_service.dart';

abstract class AuthRepository {
  Future<String> initiateOnboardingMethod(
      InitiateOnboardingReq initiateOnboardingReq);
  Future<String> loginEndpoint(LoginReq loginReq);
  Future<String> verifyPhoneNo(VerifyPhoneNumberReq verifyPhoneNumberReq);
  Future<String> createPassword(CreatePasswordReq createPasswordReq);
  Future<List<NewCountryModel>> getCountries();
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
      await _authService.verifyPhoneNo(verifyPhoneNumberReq);

  @override
  Future<String> createPassword(CreatePasswordReq createPasswordReq) async =>
      await _authService.createPassword(createPasswordReq);

  @override
  Future<List<NewCountryModel>> getCountries() async =>
      await _authService.getCountries();
}
