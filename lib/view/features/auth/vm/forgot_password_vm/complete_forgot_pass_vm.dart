import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/complete_forgot_password_req.dart';

class CompleteForgotPasswordNotifier extends AutoDisposeAsyncNotifier<String> {
  Future<void> completeForgotPasswordMethod(CompleteForgotPassReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(authRepository).completeForgotPasswordEndpoint(req));
  }

  @override
  FutureOr<String> build() {
    return '';
  }
}

final completeForgotPasswordProvider =
    AsyncNotifierProvider.autoDispose<CompleteForgotPasswordNotifier, String>(
        CompleteForgotPasswordNotifier.new);
