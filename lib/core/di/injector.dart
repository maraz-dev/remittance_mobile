import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/http/dio_http_service.dart';
import 'package:remittance_mobile/core/http/http_service.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage.dart';
import 'package:remittance_mobile/core/storage/hive-storage/hive_storage_service.dart';
import 'package:remittance_mobile/core/storage/secure-storage/secure_storage.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';
import 'package:remittance_mobile/core/third-party/environment.dart';
import 'package:remittance_mobile/core/utils/app_url.dart';
import 'package:remittance_mobile/data/local/user_data_storage.dart';
import 'package:remittance_mobile/data/remote/account-remote/account_impl.dart';
import 'package:remittance_mobile/data/remote/account-remote/account_service.dart';
import 'package:remittance_mobile/data/remote/auth-remote/auth_impl.dart';
import 'package:remittance_mobile/data/remote/auth-remote/auth_service.dart';
import 'package:remittance_mobile/data/remote/kyc-remote/kyc_impl.dart';
import 'package:remittance_mobile/data/remote/kyc-remote/kyc_service.dart';
import 'package:remittance_mobile/data/remote/transactions-remote/transactions_impl.dart';
import 'package:remittance_mobile/data/remote/transactions-remote/transactions_service.dart';
import 'package:remittance_mobile/data/remote/transfer-remote/transfer_impl.dart';
import 'package:remittance_mobile/data/remote/transfer-remote/transfer_service.dart';
import 'package:remittance_mobile/domain/account_repo.dart';
import 'package:remittance_mobile/domain/auth_repo.dart';
import 'package:remittance_mobile/domain/kyc_repo.dart';
import 'package:remittance_mobile/domain/transactions_repo.dart';
import 'package:remittance_mobile/domain/transfer_repo.dart';

final inject = GetIt.instance;

Future<void> initializeCore({required Environmentx environment}) async {
  ApiEndpoints.init(environment);
  await _initializeCore();
  await _initstorage();
}

Future<void> _initializeCore() async {
  await SharedPrefManager.init();
}

/// Initialize services's here

Future<void> _initstorage() async {
  ///------------>> Storage
  inject.registerLazySingleton<SecureStorage>(() => SecureStorage());
  inject.registerLazySingleton<SecureStorageBase>(() => SecureStorage());
}

///----------------------->> Storage

final hiveStorageService = Provider<HiveStorageBase>(
  (_) => HiveStorageService(),
);

final secureStorageService = Provider<SecureStorageBase>(
  (_) => SecureStorage(),
);

final _networkService = Provider<HttpService>((ref) => NetworkService());

/// User Storage

final userStorageService = Provider<UserStorageService>((ref) {
  return UserStorageService(storageService: ref.watch(hiveStorageService));
});

// Auth Service Dependency Injection
final _authService = Provider<AuthService>((ref) {
  var network = ref.watch(_networkService);
  var hiveStorage = ref.watch(hiveStorageService);
  var secureStorage = ref.watch(secureStorageService);
  return AuthService(
    networkService: network,
    storage: secureStorage,
    hivestorage: hiveStorage,
  );
});

final authRepository = Provider<AuthRepository>(
  (ref) {
    final authService = ref.watch(_authService);
    return AuthImpl(authService);
  },
);

// KYC Service Dependency Injection
final _kycService = Provider<KycService>((ref) {
  var network = ref.watch(_networkService);
  var secureStorage = ref.watch(secureStorageService);
  return KycService(
    networkService: network,
    storage: secureStorage,
  );
});

final kycRepository = Provider<KycRepository>((ref) {
  final kycService = ref.watch(_kycService);
  return KycImpl(kycService);
});

// Account Service Dependency Injection
final _accountService = Provider<AccountService>((ref) {
  var network = ref.watch(_networkService);
  var secureStorage = ref.watch(secureStorageService);
  var hiveStorage = ref.watch(hiveStorageService);
  return AccountService(
    networkService: network,
    storage: secureStorage,
    hivestorage: hiveStorage,
  );
});

final accountRepository = Provider<AccountRepository>((ref) {
  final accountService = ref.watch(_accountService);
  return AccountImpl(accountService);
});

/// Transaction Service DI
final _transferService = Provider<TransferService>((ref) {
  var network = ref.watch(_networkService);
  return TransferService(
    networkService: network,
  );
});

final transferRepository = Provider<TransferRepo>(
  (ref) {
    final transferService = ref.watch(_transferService);
    return TransferImpl(transferService);
  },
);

/// Transaction Service DI
final _transactionsService = Provider<TransactionsService>((ref) {
  var network = ref.watch(_networkService);
  return TransactionsService(
    networkService: network,
  );
});

final transactionsRepository = Provider<TransactionsRepo>(
  (ref) {
    final transactionsService = ref.watch(_transactionsService);
    return TransactionsImpl(transactionsService);
  },
);

// /// More Service

// final _moreService = Provider<MoreService>((ref) {
//   var network = ref.watch(_networkService);
//   return MoreService(
//     networkService: network,
//   );
// });

// final moreRepository = Provider<MoreRepository>(
//   (ref) {
//     final moreService = ref.watch(_moreService);
//     return MoreImpl(moreService);
//   },
// );




// /// -------------------------------------->>>>>>>>>>   Transaction
// ///
// ///
// final _transactionService = Provider<TransactionService>((ref) {
//   var network = ref.watch(_networkService);
//   return TransactionService(networkService: network);
// });

// final transactionRepository = Provider<TransactionRepository>(
//   (ref) {
//     final provider = ref.watch(_transactionService);
//     return TransactionsManager(provider);
//   },
// );

/// -------------------------------------->>>>>>>>>>   Bank
///
///

// final _bankService = Provider<BankService>((ref) {
//   return BankService(networkService: ref.watch(_networkService));
// });

// final bankRepository = Provider<BankRepository>(
//   (ref) => BankManager(ref.watch(_bankService)),
// );

// /// -------------------------------------->>>>>>>>>>   Wallet
// ///
// ///
// final _walletService = Provider<WalletService>(
//     (ref) => WalletService(networkService: ref.watch(_networkService)));

// final walletRepository = Provider<WalletRepository>(
//     (ref) => WalletManager(ref.watch(_walletService)));


