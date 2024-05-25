import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/initiate_onboarding_req.dart';

class InitiateOnboardingNotifier extends AutoDisposeAsyncNotifier<String> {
  Future<void> initiateOnboardingMethod(InitiateOnboardingReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(authRepository).initiateOnboardingMethod(req));
  }

  @override
  FutureOr<String> build() {
    return '';
  }
}

final initiateOnboardingProvider =
    AsyncNotifierProvider.autoDispose<InitiateOnboardingNotifier, String>(
        InitiateOnboardingNotifier.new);
