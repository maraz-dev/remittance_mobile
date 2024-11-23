import 'dart:developer';
import 'dart:io';

import 'package:aws_s3_upload_lite/aws_s3_upload_lite.dart';
import 'package:config/Config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
      final response = await _networkService.request(endpointUrl.kycStatus, RequestMethod.get);

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
      final response =
          await _networkService.request("${endpointUrl.getIdDocumentsTypes}/NG", RequestMethod.get);

      return _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'] as List;
          final responseList = res.map((json) => IdTypesItem.fromJson(json)).toList();
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
          "${endpointUrl.getProofOfAddressTypes}/NG", RequestMethod.get);

      return _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'] as List;
          final responseList = res.map((json) => IdTypesItem.fromJson(json)).toList();
          return responseList;
        },
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<dynamic> uploadKycFile(File file, String fileName) async {
    final bucketName = dotenv.env["PROD_AWS_BUCKET"];
    final region = dotenv.env["PROD_AWS_REGION"];
    final accessKey = dotenv.env["PROD_AWS_ACCESS_KEY"];
    final secretKey = dotenv.env["PROD_AWS_SECRET_KEY"];

    try {
      // Variable to get the extention
      final String extension = file.path.split('.').last;

      // Variable to hold the file path
      final filePath =
          "Kyc/$APP_PARTNER_CODE/Individual/${SharedPrefManager.userId}/$fileName.$extension";

      // Method to Upload
      final response = await AwsS3.uploadFile(
        accessKey: accessKey!,
        secretKey: secretKey!,
        bucket: bucketName!,
        region: region!,
        file: file,
        key: filePath,
        destDir: "Kyc/$APP_PARTNER_CODE/Individual/${SharedPrefManager.userId}",
        filename: fileName,
        onUploadProgress: (sentBytes, totalBytes) {
          log('Upload Progress: ${((sentBytes / totalBytes) * 100).toStringAsFixed(2)}%');
        },
      );
      if (response == '200' || response == '204') {
        log("File Path: ${file.path}");
        log("S3 Bucket Message: $response");
        return filePath;
      } else {
        log(response);
        kDebugMode ? throw response : throw "Opps! An Error Occured";
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<KycSubmission> initiateKycEndpoint() async {
    // Add the User ID which is the Request ID
    kycData.addAll({
      'RequestId': SharedPrefManager.onboardingRequestId,
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
