import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/responses/customer_transaction_model.dart';

class GetCustomerTransxNotifier extends AutoDisposeAsyncNotifier<List<TransactionsRes>> {
  Future<void> getCustomerTransxMethod() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(transactionsRepository).getCustomerTransactions(),
    );
  }

  @override
  FutureOr<List<TransactionsRes>> build() {
    return [];
  }
}

final getCustomerTranxProvider =
    AsyncNotifierProvider.autoDispose<GetCustomerTransxNotifier, List<TransactionsRes>>(
        GetCustomerTransxNotifier.new);
