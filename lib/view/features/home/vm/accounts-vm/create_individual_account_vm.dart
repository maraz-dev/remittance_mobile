import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/create_customer_req.dart';
import 'package:remittance_mobile/data/models/responses/account_model.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/account_providers.dart';

class CreateCustomerAccountNotifier
    extends AutoDisposeAsyncNotifier<AccountModel> {
  Future<void> createAccountMethod(CreateCustomerAccountReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(accountRepository).createIndividualAccountEndpoint(req));
    if (!state.hasError) {
      ref.invalidate(getCustomerAccountsProvider);
    }
  }

  @override
  FutureOr<AccountModel> build() {
    return AccountModel();
  }
}

final createCustomerAccountProvider = AsyncNotifierProvider.autoDispose<
    CreateCustomerAccountNotifier,
    AccountModel>(CreateCustomerAccountNotifier.new);
