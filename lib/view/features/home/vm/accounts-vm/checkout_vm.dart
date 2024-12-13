import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/checkout_req.dart';
import 'package:remittance_mobile/data/models/responses/checkout_model.dart';

class FundWithCheckoutNotifier extends AutoDisposeAsyncNotifier<CheckoutDto> {
  Future<void> fundWithCheckoutMethod(CheckoutReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(accountRepository).fundWithCheckoutEndpoint(req),
    );
  }

  @override
  FutureOr<CheckoutDto> build() {
    return CheckoutDto();
  }
}

final fundWithCheckoutProvider =
    AsyncNotifierProvider.autoDispose<FundWithCheckoutNotifier, CheckoutDto>(
        FundWithCheckoutNotifier.new);
