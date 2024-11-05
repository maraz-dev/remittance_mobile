import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';
import 'package:remittance_mobile/data/models/requests/login_req.dart';
import 'package:remittance_mobile/view/utils/session-manager/session_timeout_manager.dart';
import 'package:remittance_mobile/view/utils/session-manager/vm/app_session_vm.dart';

class LoginNotifier extends AutoDisposeAsyncNotifier<bool> {
  Future<void> loginMethod(LoginReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(authRepository).loginEndpoint(req));

    if (!state.hasError) {
      ref.read(sessionStateProvider).add(SessionState.startListening);
      SharedPrefManager.isLoggedIn = true;
      SharedPrefManager.isFirstLaunch = false;
    }
  }

  @override
  FutureOr<bool> build() {
    return false;
  }
}

final loginProvider = AsyncNotifierProvider.autoDispose<LoginNotifier, bool>(LoginNotifier.new);
