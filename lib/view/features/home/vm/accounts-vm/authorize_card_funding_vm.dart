import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/authorize_charge_req.dart';

class PinCardAuthorizeNotifier extends AutoDisposeAsyncNotifier<String> {
  Future<void> authorizeCardPinMethod(PinAuthorizationReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(accountRepository).authorizePINCardFunding(req),
    );
    if (!state.hasError) {
      //ref.invalidate(getCustomerAccountsProvider);
    }
  }

  @override
  FutureOr<String> build() {
    return "";
  }
}

final authorizeCardPinProvider =
    AsyncNotifierProvider.autoDispose<PinCardAuthorizeNotifier, String>(
        PinCardAuthorizeNotifier.new);

class AvsCardAuthorizeNotifier extends AutoDisposeAsyncNotifier<String> {
  Future<void> authorizeCardAvsMethod(AvsAuthorizationReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(accountRepository).authorizeAVSCardFunding(req),
    );
    if (!state.hasError) {
      //ref.invalidate(getCustomerAccountsProvider);
    }
  }

  @override
  FutureOr<String> build() {
    return "";
  }
}

final authorizeCardAvsProvider =
    AsyncNotifierProvider.autoDispose<AvsCardAuthorizeNotifier, String>(
        AvsCardAuthorizeNotifier.new);
