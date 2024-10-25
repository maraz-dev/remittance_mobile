import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/requests/add_beneficiary_req.dart';
import 'package:remittance_mobile/data/models/responses/beneficiary_model.dart';
import 'package:remittance_mobile/view/features/services/vm/services_vm.dart';

class AddBeneficiaryNotifier extends AutoDisposeAsyncNotifier<BeneficiaryModel> {
  Future<void> addBeneficiaryMethod(AddBeneficiaryReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(transferRepository).addBeneficiaryEndpoint(req),
    );
    if (!state.hasError) {
      ref.invalidate(getBeneficiariesProvider);
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
