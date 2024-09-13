import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/inititiate_ussd_funding_req.dart';
import 'package:remittance_mobile/data/models/responses/account_model.dart';
import 'package:remittance_mobile/data/models/responses/card_funding_response_model.dart';
import 'package:remittance_mobile/view/features/home/vm/accounts-vm/account_providers.dart';

class FundWithUSSDNotifier
    extends AutoDisposeAsyncNotifier<CardFundingResponseModel> {
  Future<void> fundWithUssdMethod(InitiateUssdFundingReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(accountRepository).fundWithUssdEndpoint(req),
    );
    if (!state.hasError) {
      ref.invalidate(getCustomerAccountsProvider);
    }
  }

  @override
  FutureOr<CardFundingResponseModel> build() {
    return CardFundingResponseModel();
  }
}

final fundWithUssdProvider =
    AsyncNotifierProvider.autoDispose<FundWithUSSDNotifier, AccountModel>(
        FundWithUSSDNotifier.new);
