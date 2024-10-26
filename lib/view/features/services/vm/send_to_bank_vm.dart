import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/send_money_to_bank_req.dart';
import 'package:remittance_mobile/data/models/responses/send_money_response.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/account_providers.dart';
import 'package:remittance_mobile/view/features/transactions/vm/get_customer_transx_vm.dart';

class SendToBankNotifier extends AutoDisposeAsyncNotifier<SendMoneyResponse> {
  Future<void> sendToBankMethod(SendToBankReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(transferRepository).sendMoneyToBankEndpoint(req),
    );
    if (!state.hasError) {
      ref.invalidate(getCustomerAccountsProvider);
      ref.read(getCustomerTranxProvider.notifier).getCustomerTransxMethod();
    }
  }

  @override
  FutureOr<SendMoneyResponse> build() {
    return SendMoneyResponse();
  }
}

final sendToBankProvider = AsyncNotifierProvider.autoDispose<SendToBankNotifier, SendMoneyResponse>(
    SendToBankNotifier.new);
