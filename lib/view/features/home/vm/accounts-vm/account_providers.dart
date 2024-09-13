import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';

final getCustomerAccountsProvider = FutureProvider.autoDispose((ref) async {
  return ref.read(accountRepository).getAccountsEndpoint();
});

final getAccountsCurrencyProvider = FutureProvider.autoDispose((ref) async {
  return ref.read(accountRepository).getAccountOpeningCurrenciesEndpoint();
});
