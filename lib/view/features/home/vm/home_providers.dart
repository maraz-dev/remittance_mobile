import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';

final getKycStatusProvider = FutureProvider.autoDispose((ref) async {
  return ref.read(kycRepository).getKycStatus();
});
