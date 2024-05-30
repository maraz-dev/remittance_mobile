import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/security_questions_req.dart';

class ValidateSecurityQuestionNotifier
    extends AutoDisposeAsyncNotifier<String> {
  Future<void> validateSecurityQuestionMethod(SecurityQuestionReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepository).validateSecurityQuestionEndpoint(req),
    );
  }

  @override
  FutureOr<String> build() => '';
}

final validateSecurityQuestionProvider =
    AsyncNotifierProvider.autoDispose<ValidateSecurityQuestionNotifier, String>(
        ValidateSecurityQuestionNotifier.new);
