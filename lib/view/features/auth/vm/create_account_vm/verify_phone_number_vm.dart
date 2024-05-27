import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/verify_phone_number_req.dart';

class VerifyPhoneNumberNotifier extends AutoDisposeAsyncNotifier<String> {
  Future<void> verifyPhoneNumberMethod(VerifyPhoneNumberReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(authRepository).verifyPhoneNo(req));
  }

  @override
  FutureOr<String> build() {
    return '';
  }
}

final verifyPhoneNumberProvider =
    AsyncNotifierProvider.autoDispose<VerifyPhoneNumberNotifier, String>(
        VerifyPhoneNumberNotifier.new);
