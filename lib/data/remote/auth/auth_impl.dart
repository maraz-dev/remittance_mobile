import 'package:remittance_mobile/data/models/requests/initiate_onboarding_req.dart';
import 'package:remittance_mobile/data/models/requests/login_req.dart';
import 'package:remittance_mobile/data/remote/auth/auth_service.dart';

abstract class AuthRepository {
  Future<String> initiateOnboardingMethod(
      InitiateOnboardingReq initiateOnboardingReq);
  Future<String> loginEndpoint(LoginReq loginReq);
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
}
