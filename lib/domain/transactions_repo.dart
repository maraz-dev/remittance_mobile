import 'package:remittance_mobile/data/models/responses/customer_transaction_model.dart';
import 'package:remittance_mobile/data/models/responses/transaction_detail_model.dart';

abstract class TransactionsRepo {
  Future<List<TransactionsRes>> getCustomerTransactions();
  Future<TransactionDetailRes> getTransactionDetail(String requestId);
}
