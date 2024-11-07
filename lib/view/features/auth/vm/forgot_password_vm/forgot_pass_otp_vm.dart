import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/forgot_pass_verify_otp.dart';

class ForgotPassOtpNotifier extends AutoDisposeAsyncNotifier<String> {
  Future<void> verifyForgotPassOTPMethod(ForgotPasswordOtpReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(authRepository).verifyForgotPasswordOTPEndpoint(req));
  }

  @override
  FutureOr<String> build() {
    return '';
  }
}

final verifyForgotPassOTPProvider =
    AsyncNotifierProvider.autoDispose<ForgotPassOtpNotifier, String>(
        ForgotPassOtpNotifier.new);
