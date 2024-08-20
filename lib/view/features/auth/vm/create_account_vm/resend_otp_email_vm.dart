import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';

class ResendOTPViaEmailNotifier extends AutoDisposeAsyncNotifier<String> {
  Future<void> resendOtpEmailMethod() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(authRepository).resendViaEmailEndpoint());
  }

  @override
  FutureOr<String> build() {
    return '';
  }
}

final resendOtpViaEmailProvider =
    AsyncNotifierProvider.autoDispose<ResendOTPViaEmailNotifier, String>(
        ResendOTPViaEmailNotifier.new);
