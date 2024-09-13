import 'package:remittance_mobile/data/models/requests/create_customer_req.dart';
import 'package:remittance_mobile/data/models/responses/account_currencies_model.dart';
import 'package:remittance_mobile/data/models/responses/account_model.dart';
import 'package:remittance_mobile/data/remote/account-remote/account_service.dart';
import 'package:remittance_mobile/domain/account_repo.dart';

class AccountImpl implements AccountRepository {
  final AccountService _accountService;

  AccountImpl(this._accountService);

  @override
  Future<AccountModel> createIndividualAccountEndpoint(
          CreateCustomerAccountReq req) async =>
      await _accountService.createIndividualAccountEndpoint(req);

  @override
  Future<List<AccountCurrencies>> getAccountOpeningCurrenciesEndpoint() async =>
      await _accountService.getAccountOpeningCurrenciesEndpoint();

  @override
  Future<List<AccountModel>> getAccountsEndpoint() async =>
      await _accountService.getAccountsEndpoint();
}
