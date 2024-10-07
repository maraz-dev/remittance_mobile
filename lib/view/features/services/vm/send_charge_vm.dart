import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/send_money_charge.dart';
import 'package:remittance_mobile/data/models/responses/send_charge_response.dart';

class SendChargeNotifier extends AutoDisposeAsyncNotifier<SendChargeResponse> {
  Future<void> sendChargeMethod(SendChargeReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(accountRepository).sendMoneyChargeEndpoint(req),
    );
    if (!state.hasError) {
      //ref.invalidate(getCustomerAccountsProvider);
    }
  }

  @override
  FutureOr<SendChargeResponse> build() {
    return SendChargeResponse();
  }
}

final sendChargeProvider =
    AsyncNotifierProvider.autoDispose<SendChargeNotifier, SendChargeResponse>(
        SendChargeNotifier.new);
