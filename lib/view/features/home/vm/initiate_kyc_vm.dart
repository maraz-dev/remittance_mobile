import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/responses/kyc_submission_model.dart';
import 'package:remittance_mobile/view/features/home/vm/home_providers.dart';

class InitateKycNotifier extends AutoDisposeAsyncNotifier<KycSubmission> {
  Future<void> initiateKycMethod() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(kycRepository).initiateKyc());
    if (!state.hasError) {
      ref.invalidate(getKycStatusProvider);
    }
  }

  @override
  FutureOr<KycSubmission> build() {
    return KycSubmission();
  }
}

final initiateKycProvider =
    AsyncNotifierProvider.autoDispose<InitateKycNotifier, KycSubmission>(InitateKycNotifier.new);
