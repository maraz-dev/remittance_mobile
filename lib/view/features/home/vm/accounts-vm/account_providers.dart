import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/responses/banks_model.dart';

final getCustomerAccountsProvider = FutureProvider.autoDispose((ref) async {
  return ref.read(accountRepository).getAccountsEndpoint();
});

final getAccountsCurrencyProvider = FutureProvider.autoDispose((ref) async {
  return ref.read(accountRepository).getAccountOpeningCurrenciesEndpoint();
});

// final getInidividualAccountsCurrencyProvider =
//     FutureProvider.autoDispose.family<AccountModel, String>((ref, args) async {
//   return ref.read(accountRepository).getIndividualAccountsEndpoint(args);
// });

final getBanksProvider = FutureProvider.autoDispose
    .family<List<BanksModel>, String>((ref, args) async {
  return ref.read(accountRepository).getBanksEndpoint(args);
});
