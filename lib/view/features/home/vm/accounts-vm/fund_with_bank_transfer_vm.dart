import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/fund_with_bank_transfer_req.dart';
import 'package:remittance_mobile/data/models/responses/fund_with_bank_transfer_dto.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/account_providers.dart';

class FundWithBankTransferNotifier extends AutoDisposeAsyncNotifier<FundWithBankTransferDto> {
  Future<void> fundWithBankTransferMethod(FundWithBankTransferReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(accountRepository).fundWithBankTransferEndpoint(req),
    );
    if (!state.hasError) {
      ref.invalidate(getCustomerAccountsProvider);
    }
  }

  @override
  FutureOr<FundWithBankTransferDto> build() {
    return FundWithBankTransferDto();
  }
}

final fundWithBankTransferProvider =
    AsyncNotifierProvider.autoDispose<FundWithBankTransferNotifier, FundWithBankTransferDto>(
        FundWithBankTransferNotifier.new);
