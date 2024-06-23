import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/responses/kyc_submission_model.dart';

class InitateKycNotifier extends AutoDisposeAsyncNotifier<KycSubmission> {
  Future<void> initiateKycMethod() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(kycRepository).initiateKyc());
  }

  @override
  FutureOr<KycSubmission> build() {
    return KycSubmission();
  }
}

final initiateKycProvider =
    AsyncNotifierProvider.autoDispose<InitateKycNotifier, KycSubmission>(
        InitateKycNotifier.new);
