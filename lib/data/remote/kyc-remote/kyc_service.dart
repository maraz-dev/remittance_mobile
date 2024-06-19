import 'package:remittance_mobile/core/http/http_service.dart';
import 'package:remittance_mobile/core/http/response_body_handler.dart';
import 'package:remittance_mobile/core/utils/app_url.dart';
import 'package:remittance_mobile/data/models/responses/id_types_item_model.dart';
import 'package:remittance_mobile/data/models/responses/kyc_status_model.dart';

class KycService {
  final HttpService _networkService;

  KycService({
    required HttpService networkService,
  }) : _networkService = networkService;

  // Endpoint URL Instance
  final endpointUrl = ApiEndpoints.instance;

  // Class to Handle API Response
  final ResponseHandler _responseHandler = ResponseHandler();

  Future<KycStatus> getKycStatusEndpoint() async {
    try {
      final response = await _networkService.request(
          endpointUrl.kycStatus, RequestMethod.get);

      _responseHandler.handleResponse(
          response: response.data,
          onSuccess: () {
            KycStatus.fromJson(response.data['data']);
          });
      return KycStatus.fromJson(response.data['data']);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<IdTypesItem>> getIdTypesEndpoint() async {
    try {
      final response = await _networkService.request(
          endpointUrl.getIdDocumentsTypes, RequestMethod.get);

      return _responseHandler.handleResponse(
          response: response.data['data'],
          onSuccess: () {
            final res = response.data['data'] as List;
            final responseList =
                res.map((json) => IdTypesItem.fromJson(json)).toList();
            return responseList;
          });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<IdTypesItem>> getProofOfAddressEndpoint() async {
    try {
      final response = await _networkService.request(
          endpointUrl.getProofOfAddressTypes, RequestMethod.get);

      return _responseHandler.handleResponse(
          response: response.data['data'],
          onSuccess: () {
            final res = response.data['data'] as List;
            final responseList =
                res.map((json) => IdTypesItem.fromJson(json)).toList();
            return responseList;
          });
    } catch (e) {
      throw e.toString();
    }
  }
}
