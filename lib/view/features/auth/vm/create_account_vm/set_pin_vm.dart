import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/set_pin_req.dart';

class SetPinNotifier extends AutoDisposeAsyncNotifier<String> {
  Future<void> setPINMethod(SetPinReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(authRepository).setPinEndpoint(req));
  }

  @override
  FutureOr<String> build() {
    return '';
  }
}

final setPINProvider =
    AsyncNotifierProvider.autoDispose<SetPinNotifier, String>(
        SetPinNotifier.new);
