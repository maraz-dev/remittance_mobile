import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/responses/corridor_response.dart';

final getCorridorsProvider =
    FutureProvider.family<List<CorridorsResponse>, String>((ref, args) async {
  return ref.read(transferRepository).getCorridorsEndpoint(args);
});

final getBeneficiariesProvider = FutureProvider.autoDispose((ref) async {
  return ref.read(transferRepository).getBeneficiariesEndpoint();
});
