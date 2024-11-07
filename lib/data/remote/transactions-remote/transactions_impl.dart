import 'package:remittance_mobile/data/models/responses/customer_transaction_model.dart';
import 'package:remittance_mobile/data/models/responses/transaction_detail_model.dart';
import 'package:remittance_mobile/data/remote/transactions-remote/transactions_service.dart';
import 'package:remittance_mobile/domain/transactions_repo.dart';

class TransactionsImpl implements TransactionsRepo {
  final TransactionsService _transactionsService;

  TransactionsImpl(this._transactionsService);

  @override
  Future<List<TransactionsRes>> getCustomerTransactions() async =>
      await _transactionsService.getCustomerTransactions();

  @override
  Future<TransactionDetailRes> getTransactionDetail(String requestId) async =>
      await _transactionsService.getTransactionDetail(requestId);
}
