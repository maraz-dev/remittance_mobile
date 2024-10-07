import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/send_money_to_mobile_money.dart';
import 'package:remittance_mobile/data/models/responses/send_money_response.dart';

class SendToAppUserNotifier
    extends AutoDisposeAsyncNotifier<SendMoneyResponse> {
  Future<void> sendToAppUserMethod(SendToMobileMoneyReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(accountRepository).sendMoneyToInAppUserEndpoint(req),
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

final sendToAppUserProvider =
    AsyncNotifierProvider.autoDispose<SendToAppUserNotifier, SendMoneyResponse>(
        SendToAppUserNotifier.new);
