import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/initiate_card_funding_req.dart';
import 'package:remittance_mobile/data/models/responses/card_funding_response_model.dart';

class FundWithCardNotifier
    extends AutoDisposeAsyncNotifier<CardFundingResponseModel> {
  Future<void> fundWithCardMethod(InitiateCardFundingReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(accountRepository).fundWithCardEndpoint(req),
    );
    if (!state.hasError) {
      //ref.invalidate(getCustomerAccountsProvider);
    }
  }

  @override
  FutureOr<CardFundingResponseModel> build() {
    return CardFundingResponseModel();
  }
}

final fundWithCardProvider = AsyncNotifierProvider.autoDispose<
    FundWithCardNotifier, CardFundingResponseModel>(FundWithCardNotifier.new);
