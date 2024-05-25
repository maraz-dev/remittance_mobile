import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/login_req.dart';

class LoginNotifier extends AutoDisposeAsyncNotifier<String> {
  Future<void> loginMethod(LoginReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(authRepository).loginEndpoint(req));
  }

  @override
  FutureOr<String> build() {
    return '';
  }
}

final loginProvider =
    AsyncNotifierProvider.autoDispose<LoginNotifier, String>(LoginNotifier.new);
