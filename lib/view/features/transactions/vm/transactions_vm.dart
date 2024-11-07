import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/responses/transaction_detail_model.dart';

final getTransactionDetailProvider =
    FutureProvider.autoDispose.family<TransactionDetailRes, String>((ref, args) async {
  return ref.read(transactionsRepository).getTransactionDetail(args);
});
