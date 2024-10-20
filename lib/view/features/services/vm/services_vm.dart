import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/responses/corridor_response.dart';

final getCorridorsProvider = FutureProvider.autoDispose
    .family<List<CorridorsResponse>, String>((ref, args) async {
  return ref.read(accountRepository).getCorridorsEndpoint(args);
});

final getBeneficiariesProvider = FutureProvider.autoDispose((ref) async {
  return ref.read(accountRepository).getBeneficiariesEndpoint();
});
