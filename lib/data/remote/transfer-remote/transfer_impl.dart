import 'package:remittance_mobile/data/models/requests/add_beneficiary_req.dart';
import 'package:remittance_mobile/data/models/requests/send_money_charge.dart';
import 'package:remittance_mobile/data/models/requests/send_money_to_bank_req.dart';
import 'package:remittance_mobile/data/models/requests/send_money_to_mobile_money.dart';
import 'package:remittance_mobile/data/models/responses/beneficiary_model.dart';
import 'package:remittance_mobile/data/models/responses/corridor_response.dart';
import 'package:remittance_mobile/data/models/responses/send_charge_response.dart';
import 'package:remittance_mobile/data/models/responses/send_money_response.dart';
import 'package:remittance_mobile/data/remote/transfer-remote/transfer_service.dart';
import 'package:remittance_mobile/domain/transfer_repo.dart';

class TransferImpl implements TransferRepo {
  final TransferService _transferService;

  TransferImpl(this._transferService);

  @override
  Future<SendChargeResponse> sendMoneyChargeEndpoint(SendChargeReq req) async =>
      await _transferService.sendMoneyChargeEndpoint(req);

  @override
  Future<SendMoneyResponse> sendMoneyToBankEndpoint(SendToBankReq req) async =>
      await _transferService.sendMoneyToBankEndpoint(req);

  @override
  Future<SendMoneyResponse> sendMoneyToInAppUserEndpoint(SendToMobileMoneyReq req) async =>
      await _transferService.sendMoneyToInAppUserEndpoint(req);

  @override
  Future<SendMoneyResponse> sendMoneyToMobileMoneyEndpoint(SendToMobileMoneyReq req) async =>
      await _transferService.sendMoneyToMobileMoneyEndpoint(req);

  @override
  Future<List<CorridorsResponse>> getCorridorsEndpoint(String country) async =>
      await _transferService.getCorridorsEndpoint(country);

  @override
  Future<BeneficiaryModel> addBeneficiaryEndpoint(AddBeneficiaryReq req) async =>
      await _transferService.addBeneficiaryEndpoint(req);

  @override
  Future<List<BeneficiaryModel>> getBeneficiariesEndpoint() async =>
      await _transferService.getBeneficiariesEndpoint();
}
