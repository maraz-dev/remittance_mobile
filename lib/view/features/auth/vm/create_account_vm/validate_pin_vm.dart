import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';

class ValidatePinNotifier extends AutoDisposeAsyncNotifier<String> {
  Future<void> validatePINMethod(String pin) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(authRepository).validatePinEndpoint(pin));
  }

  @override
  FutureOr<String> build() {
    return '';
  }
}

final validatePINProvider =
    AsyncNotifierProvider.autoDispose<ValidatePinNotifier, String>(
        ValidatePinNotifier.new);
