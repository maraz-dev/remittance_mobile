import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/initiate_forgot_password_req.dart';

class InitiateForgotPasswordNotifier extends AutoDisposeAsyncNotifier<String> {
  Future<void> initiateForgotPasswordMethod(InitiateForgotPassReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(authRepository).initiateForgotPasswordEndpoint(req));
  }

  @override
  FutureOr<String> build() {
    return '';
  }
}

final initiateForgotPasswordProvider =
    AsyncNotifierProvider.autoDispose<InitiateForgotPasswordNotifier, String>(
        InitiateForgotPasswordNotifier.new);
