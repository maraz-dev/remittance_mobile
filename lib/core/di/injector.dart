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
import 'package:remittance_mobile/data/remote/auth/auth_impl.dart';
import 'package:remittance_mobile/data/remote/auth/auth_service.dart';
import 'package:remittance_mobile/domain/auth_repo.dart';

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
      hivestorage: hiveStorage);
});

final authRepository = Provider<AuthRepository>(
  (ref) {
    final authService = ref.watch(_authService);
    return AuthImpl(authService);
  },
);

// /// Dashboard Service
// final _transactionsService = Provider<TransactionsService>((ref) {
//   var network = ref.watch(_networkService);
//   return TransactionsService(
//     networkService: network,
//   );
// });

// final transactionsRepository = Provider<TransactionsRepository>(
//   (ref) {
//     final transactionsService = ref.watch(_transactionsService);
//     return TransactionsImpl(transactionsService);
//   },
// );

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


