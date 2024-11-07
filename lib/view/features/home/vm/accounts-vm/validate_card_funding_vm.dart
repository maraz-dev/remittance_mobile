import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/core/storage/secure-storage/secure_storage.dart';
import 'package:remittance_mobile/data/models/responses/validate_card_funding_model.dart';

class ValidateFundingNotifier
    extends AutoDisposeAsyncNotifier<ValidateCardFundingModel> {
  Future<void> validateFundingMethod(String otp) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(accountRepository).validateCardFunding(otp),
    );
    var storage = inject.get<SecureStorageBase>();
    if (!state.hasError) {
      storage.saveData('fundingId', state.value?.requestId ?? "");
      storage.saveData('flwId', state.value?.flwTransactionId.toString() ?? "");
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
