import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/verify_transx_req.dart';
import 'package:remittance_mobile/data/models/responses/verify_transx_model.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/account_providers.dart';
import 'package:remittance_mobile/view/features/transactions/vm/get_customer_transx_vm.dart';

class VerifyFundingTransxNotifier extends AutoDisposeAsyncNotifier<VerifyFundingTransxModel> {
  Future<void> verifyFundingTransxMethod(VerifyFundingTransxReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(accountRepository).verifyFundingTransxEndpoint(req),
    );
    if (!state.hasError) {
      ref.invalidate(getCustomerAccountsProvider);
      ref.read(getCustomerTranxProvider.notifier).getCustomerTransxMethod();
    } else if ((state.value?.isSuccessful ?? false) && !(state.value?.isCompleted ?? false)) {
      ref.invalidateSelf();
    }
  }

  @override
  FutureOr<VerifyFundingTransxModel> build() {
    return VerifyFundingTransxModel();
  }
}

final verifyFundingTransxProvider =
    AsyncNotifierProvider.autoDispose<VerifyFundingTransxNotifier, VerifyFundingTransxModel>(
        VerifyFundingTransxNotifier.new);
