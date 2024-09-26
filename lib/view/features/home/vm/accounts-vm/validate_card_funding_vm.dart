import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/responses/validate_card_funding_model.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/account_providers.dart';

class ValidateFundingNotifier
    extends AutoDisposeAsyncNotifier<ValidateCardFundingModel> {
  Future<void> validateFundingMethod(String otp) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(accountRepository).validateCardFunding(otp),
    );
    if (!state.hasError) {
      ref.invalidate(getCustomerAccountsProvider);
    }
  }

  @override
  FutureOr<ValidateCardFundingModel> build() {
    return ValidateCardFundingModel();
  }
}

final validateFundingProvider = AsyncNotifierProvider.autoDispose<
    ValidateFundingNotifier,
    ValidateCardFundingModel>(ValidateFundingNotifier.new);
