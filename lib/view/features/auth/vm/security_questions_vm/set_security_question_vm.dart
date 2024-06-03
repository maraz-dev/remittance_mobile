import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/set_security_question_req.dart';

class SetSecurityQuestionNotifier extends AutoDisposeAsyncNotifier<String> {
  Future<void> setSecurityQuestionMethod(SetSecurityQuestionReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepository).setSecurityQuestionEndpoint(req),
    );
  }

  @override
  FutureOr<String> build() => '';
}

final setSecurityQuestionProvider =
    AsyncNotifierProvider.autoDispose<SetSecurityQuestionNotifier, String>(
        SetSecurityQuestionNotifier.new);
