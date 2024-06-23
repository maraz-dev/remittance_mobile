import 'package:dio/dio.dart';
import 'package:remittance_mobile/core/http/http_service.dart';
import 'package:remittance_mobile/core/http/response_body_handler.dart';
import 'package:remittance_mobile/core/storage/secure-storage/secure_storage.dart';
import 'package:remittance_mobile/core/storage/share_pref.dart';
import 'package:remittance_mobile/core/utils/app_url.dart';
import 'package:remittance_mobile/data/models/responses/id_types_item_model.dart';
import 'package:remittance_mobile/data/models/responses/kyc_status_model.dart';
import 'package:remittance_mobile/data/models/responses/kyc_submission_model.dart';

Map<String, dynamic> kycData = {};

class KycService {
  final HttpService _networkService;
  final SecureStorageBase _storage;

  KycService({
    required HttpService networkService,
    required SecureStorageBase storage,
  })  : _networkService = networkService,
        _storage = storage;

  // Endpoint URL Instance
  final endpointUrl = ApiEndpoints.instance;

  // Class to Handle API Response
  final ResponseHandler _responseHandler = ResponseHandler();

  Future<KycStatus> getKycStatusEndpoint() async {
    try {
      final response = await _networkService.request(
          endpointUrl.kycStatus, RequestMethod.get);

      return _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          return KycStatus.fromJson(response.data['data']);
        },
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<IdTypesItem>> getIdTypesEndpoint() async {
    try {
      final response = await _networkService.request(
          "${endpointUrl.getIdDocumentsTypes}?countryCode=", RequestMethod.get);

      return _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'] as List;
          final responseList =
              res.map((json) => IdTypesItem.fromJson(json)).toList();
          return responseList;
        },
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<IdTypesItem>> getProofOfAddressEndpoint() async {
    try {
      final response = await _networkService.request(
          "${endpointUrl.getProofOfAddressTypes}?countryCode=",
          RequestMethod.get);

      return _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'] as List;
          final responseList =
              res.map((json) => IdTypesItem.fromJson(json)).toList();
          return responseList;
        },
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<KycSubmission> initiateKycEndpoint() async {
    // Add the User ID which is the Request ID
    kycData.addAll({
      'RequestId': SharedPrefManager.userId,
    });

    try {
      final response = await _networkService.request(
        endpointUrl.initiateKYC,
        RequestMethod.upload,
        options: Options(
          headers: {
            "Authorization": "Bearer ${await _storage.readData('token')} ",
            "Content-Disposition": "form-data",
            "Content-Type": "multipart/form-data",
            'Accept': 'application/json'
          },
        ),
        formData: FormData.fromMap(kycData),
      );

      return _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          return KycSubmission.fromJson(response.data['data']);
        },
      );
    } catch (e) {
      throw e.toString();
    }
  }
}
