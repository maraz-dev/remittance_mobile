import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/validate_acc_no_req.dart';

class ValidateAccountNumberNotifier extends AutoDisposeAsyncNotifier<String> {
  Future<void> validateAccountMethod(ValidateAccountNumberReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(transferRepository).validateAccountNumberEndpoint(req),
    );
  }

  @override
  FutureOr<String> build() {
    return "";
  }
}

final validateAccountNumberProvider =
    AsyncNotifierProvider.autoDispose<ValidateAccountNumberNotifier, String>(
        ValidateAccountNumberNotifier.new);
