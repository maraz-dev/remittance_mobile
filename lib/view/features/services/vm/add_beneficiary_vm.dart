import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/add_beneficiary_req.dart';
import 'package:remittance_mobile/data/models/responses/beneficiary_model.dart';

class AddBeneficiaryNotifier
    extends AutoDisposeAsyncNotifier<BeneficiaryModel> {
  Future<void> sendChargeMethod(AddBeneficiaryReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(accountRepository).addBeneficiaryEndpoint(req),
    );
    if (!state.hasError) {
      //ref.invalidate(getCustomerAccountsProvider);
    }
  }

  @override
  FutureOr<BeneficiaryModel> build() {
    return BeneficiaryModel();
  }
}

final addBeneficiaryProvider =
    AsyncNotifierProvider.autoDispose<AddBeneficiaryNotifier, BeneficiaryModel>(
        AddBeneficiaryNotifier.new);
