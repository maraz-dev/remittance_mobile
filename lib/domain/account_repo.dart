import 'package:remittance_mobile/data/models/requests/create_customer_req.dart';
import 'package:remittance_mobile/data/models/responses/account_currencies_model.dart';
import 'package:remittance_mobile/data/models/responses/account_model.dart';

abstract class AccountRepository {
  Future<List<AccountCurrencies>> getAccountOpeningCurrenciesEndpoint();
  Future<List<AccountModel>> getAccountsEndpoint();
  Future<AccountModel> createIndividualAccountEndpoint(
      CreateCustomerAccountReq req);
}
