import 'package:dio/dio.dart';
import 'package:remittance_mobile/core/http/http_service.dart';
import 'package:remittance_mobile/core/http/response_body_handler.dart';
import 'package:remittance_mobile/core/utils/app_url.dart';
import 'package:remittance_mobile/core/utils/device_details.dart';
import 'package:remittance_mobile/core/utils/generate_uuid.dart';
import 'package:remittance_mobile/core/utils/get_ip_address.dart';
import 'package:remittance_mobile/core/utils/location_services.dart';
import 'package:remittance_mobile/data/models/requests/add_beneficiary_req.dart';
import 'package:remittance_mobile/data/models/requests/send_money_charge.dart';
import 'package:remittance_mobile/data/models/requests/send_money_to_bank_req.dart';
import 'package:remittance_mobile/data/models/requests/send_money_to_mobile_money.dart';
import 'package:remittance_mobile/data/models/requests/validate_acc_no_req.dart';
import 'package:remittance_mobile/data/models/responses/beneficiary_model.dart';
import 'package:remittance_mobile/data/models/responses/corridor_response.dart';
import 'package:remittance_mobile/data/models/responses/send_charge_response.dart';
import 'package:remittance_mobile/data/models/responses/send_money_response.dart';

class TransferService {
  final HttpService _networkService;

  TransferService({
    required HttpService networkService,
  }) : _networkService = networkService;

  // Endpoint URL Instance
  final endpointUrl = ApiEndpoints.instance;

  // Class to Handle API Response
  final ResponseHandler _responseHandler = ResponseHandler();

  // Get Bank Corridors
  Future<List<CorridorsResponse>> getCorridorsEndpoint(String country) async {
    try {
      final response = await _networkService.request(
        '${endpointUrl.baseFundingUrl}${endpointUrl.getCorridors}?sourceCountryCode=$country',
        RequestMethod.get,
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          final responseList = res['corridors'] as List;
          return responseList.map((list) => CorridorsResponse.fromJson(list)).toList();
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Get Beneficiaries
  Future<List<BeneficiaryModel>> getBeneficiariesEndpoint() async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseFundingUrl + endpointUrl.getBeneficiaries,
        RequestMethod.get,
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final responseList = response.data['data'] as List;
          return responseList.map((list) => BeneficiaryModel.fromJson(list)).toList();
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Fund with USSD Endpoint
  Future<BeneficiaryModel> addBeneficiaryEndpoint(AddBeneficiaryReq req) async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseFundingUrl + endpointUrl.addNewBeneficiaries,
        RequestMethod.post,
        data: req.toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          return BeneficiaryModel.fromJson(res);
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Send to Bank
  Future<SendMoneyResponse> sendMoneyToBankEndpoint(SendToBankReq req) async {
    String? deviceToken, ipAddress, latitude, longitude;

    try {
      await getDeviceDetails().then((value) {
        deviceToken = value[1];
      });

      // Get Device IP Address
      await getDeviceIP().then((value) {
        ipAddress = value;
      });

      // Get Location
      await determineDeviceLocation().then((value) async {
        latitude = value.latitude.toString();
        longitude = value.longitude.toString();
      });

      final response = await _networkService.request(
        options: Options(headers: {'sessionId': UUIDGenerator.generateUUID()}),
        endpointUrl.baseFundingUrl + endpointUrl.sendToBank,
        RequestMethod.post,
        data: req
            .copyWith(
              deviceToken: deviceToken,
              longitude: longitude,
              latitude: latitude,
              ipAddress: ipAddress,
              channel: "Mobile",
            )
            .toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          return SendMoneyResponse.fromJson(res);
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Validate Account Number
  Future<String> validateAccountNumberEndpoint(ValidateAccountNumberReq req) async {
    try {
      final response = await _networkService.request(
          '${endpointUrl.baseFundingUrl}${endpointUrl.validateAccountNumber}', RequestMethod.post,
          data: req.toJson());

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          return res;
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Send to Mobile Money
  Future<SendMoneyResponse> sendMoneyToMobileMoneyEndpoint(SendToMobileMoneyReq req) async {
    String? deviceToken, ipAddress, latitude, longitude;

    try {
      await getDeviceDetails().then((value) {
        deviceToken = value[1];
      });

      // Get Device IP Address
      await getDeviceIP().then((value) {
        ipAddress = value;
      });

      // Get Location
      await determineDeviceLocation().then((value) async {
        latitude = value.latitude.toString();
        longitude = value.longitude.toString();
      });

      final response = await _networkService.request(
        options: Options(headers: {'sessionId': UUIDGenerator.generateUUID()}),
        endpointUrl.baseFundingUrl + endpointUrl.sendToMobileMoney,
        RequestMethod.post,
        data: req
            .copyWith(
              latitude: latitude,
              longitude: longitude,
              ipAddress: ipAddress,
              deviceToken: deviceToken,
              channel: 'Mobile',
            )
            .toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          return SendMoneyResponse.fromJson(res);
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Send to ErrandPay User
  Future<SendMoneyResponse> sendMoneyToInAppUserEndpoint(SendToMobileMoneyReq req) async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseFundingUrl + endpointUrl.sendToInAppUser,
        RequestMethod.post,
        data: req.toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          return SendMoneyResponse.fromJson(res);
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Send to Mobile Money
  Future<SendChargeResponse> sendMoneyChargeEndpoint(SendChargeReq req) async {
    try {
      final response = await _networkService.request(
        endpointUrl.baseFundingUrl + endpointUrl.sendCharge,
        RequestMethod.post,
        data: req.toJson(),
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          return SendChargeResponse.fromJson(res);
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }
}
