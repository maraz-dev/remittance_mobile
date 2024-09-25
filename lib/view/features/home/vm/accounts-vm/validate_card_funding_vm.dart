import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';

class ValidateFundingNotifier extends AutoDisposeAsyncNotifier<bool> {
  Future<void> validateFundingMethod(String otp) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(accountRepository).validateCardFunding(otp),
    );
    if (!state.hasError) {
      //ref.invalidate(getCustomerAccountsProvider);
    }
  }

  @override
  FutureOr<bool> build() {
    return false;
  }
}

final validateFundingProvider =
    AsyncNotifierProvider.autoDispose<ValidateFundingNotifier, bool>(
        ValidateFundingNotifier.new);
