import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/send_money_to_bank_req.dart';
import 'package:remittance_mobile/data/models/responses/send_money_response.dart';

class SendToBankNotifier extends AutoDisposeAsyncNotifier<SendMoneyResponse> {
  Future<void> sendToBankMethod(SendToBankReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(accountRepository).sendMoneyToBankEndpoint(req),
    );
    if (!state.hasError) {
      //ref.invalidate(getCustomerAccountsProvider);
    }
  }

  @override
  FutureOr<SendMoneyResponse> build() {
    return SendMoneyResponse();
  }
}

final sendToBankProvider =
    AsyncNotifierProvider.autoDispose<SendToBankNotifier, SendMoneyResponse>(
        SendToBankNotifier.new);
