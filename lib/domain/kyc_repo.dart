import 'package:remittance_mobile/data/models/responses/id_types_item_model.dart';
import 'package:remittance_mobile/data/models/responses/kyc_status_model.dart';
import 'package:remittance_mobile/data/models/responses/kyc_submission_model.dart';

abstract class KycRepository {
  Future<KycStatus> getKycStatus();
  Future<List<IdTypesItem>> getIdTypesEndpoint();
  Future<List<IdTypesItem>> getProofOfAddressEndpoint();
  Future<KycSubmission> initiateKyc();
}
