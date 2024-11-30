import 'package:remittance_mobile/data/models/requests/add_beneficiary_req.dart';
import 'package:remittance_mobile/data/models/requests/send_money_charge.dart';
import 'package:remittance_mobile/data/models/requests/send_money_to_bank_req.dart';
import 'package:remittance_mobile/data/models/requests/send_money_to_mobile_money.dart';
import 'package:remittance_mobile/data/models/requests/validate_acc_no_req.dart';
import 'package:remittance_mobile/data/models/responses/beneficiary_model.dart';
import 'package:remittance_mobile/data/models/responses/corridor_response.dart';
import 'package:remittance_mobile/data/models/responses/send_charge_response.dart';
import 'package:remittance_mobile/data/models/responses/send_money_response.dart';

abstract class TransferRepo {
  Future<List<CorridorsResponse>> getCorridorsEndpoint(String country);
  Future<List<BeneficiaryModel>> getBeneficiariesEndpoint();
  Future<BeneficiaryModel> addBeneficiaryEndpoint(AddBeneficiaryReq req);
  Future<SendMoneyResponse> sendMoneyToBankEndpoint(SendToBankReq req);
  Future<String> validateAccountNumberEndpoint(ValidateAccountNumberReq req);
  Future<SendMoneyResponse> sendMoneyToMobileMoneyEndpoint(SendToMobileMoneyReq req);
  Future<SendMoneyResponse> sendMoneyToInAppUserEndpoint(SendToMobileMoneyReq req);
  Future<SendChargeResponse> sendMoneyChargeEndpoint(SendChargeReq req);
}
