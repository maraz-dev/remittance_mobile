import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/create_password_req.dart';

class CreatePasswordNotifier extends AutoDisposeAsyncNotifier<String> {
  Future<void> createPasswordMethod(CreatePasswordReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(authRepository).createPassword(req));
  }

  @override
  FutureOr<String> build() {
    return '';
  }
}

final createPasswordProvider =
    AsyncNotifierProvider.autoDispose<CreatePasswordNotifier, String>(
        CreatePasswordNotifier.new);
