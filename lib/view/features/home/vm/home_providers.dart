import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';

final getKycStatusProvider = FutureProvider.autoDispose((ref) async {
  return ref.read(kycRepository).getKycStatus();
});

final getMeansOfIDProvider = FutureProvider.autoDispose((ref) async {
  return ref.read(kycRepository).getIdTypesEndpoint();
});

final getProofOfAddressProvider = FutureProvider.autoDispose((ref) async {
  return ref.read(kycRepository).getProofOfAddressEndpoint();
});
