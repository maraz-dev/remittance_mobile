import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/data/models/responses/initiate_validate_device_res.dart';

final getCountryProvider = FutureProvider.autoDispose(
  (ref) async {
    return ref.read(authRepository).getCountries();
  },
);

final getSecurityQuestionsProvider = FutureProvider.autoDispose(
  (ref) async {
    return ref.read(authRepository).getSecurityQuestionEndpoint();
  },
);

final initiateValidateDeviceProvider =
    FutureProvider.autoDispose.family<InitiateValidateDeviceDto, String>(
  (ref, args) async {
    return ref.read(authRepository).initiateValidateDeviceEndpoint(args);
  },
);
