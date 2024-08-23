import 'package:remittance_mobile/data/remote/account-remote/account_service.dart';
import 'package:remittance_mobile/domain/account_repo.dart';

class AccountImpl implements AccountRepository {
  final AccountService _accountService;

  AccountImpl(this._accountService);
}
