import 'package:remittance_mobile/data/models/responses/id_types_item_model.dart';
import 'package:remittance_mobile/data/models/responses/kyc_status_model.dart';
import 'package:remittance_mobile/data/remote/kyc-remote/kyc_service.dart';
import 'package:remittance_mobile/domain/kyc_repo.dart';

class KycImpl implements KycRepository {
  final KycService _kycService;

  KycImpl(this._kycService);

  @override
  Future<KycStatus> getKycStatus() async =>
      await _kycService.getKycStatusEndpoint();

  @override
  Future<List<IdTypesItem>> getIdTypesEndpoint() async =>
      await _kycService.getIdTypesEndpoint();

  @override
  Future<List<IdTypesItem>> getProofOfAddressEndpoint() async =>
      await _kycService.getProofOfAddressEndpoint();
}
