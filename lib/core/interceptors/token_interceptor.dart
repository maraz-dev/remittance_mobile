// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:remittance_mobile/core/di/injector.dart';
import 'package:remittance_mobile/core/storage/secure-storage/secure_storage.dart';
import 'package:remittance_mobile/core/utils/app_url.dart';

class TokenInterceptor extends Interceptor {
  final Dio _dio;
  var storage = inject.get<SecureStorageBase>();
  TokenInterceptor(this._dio);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var key = ApiEndpoints.instance.token;

    String? token = await storage.readData(key);

    log(token);
    options.headers['Authorization'] = 'Bearer $token';

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // return super.onError(err, handler);

    // if (err.response?.statusCode == 401) {
    //   // If a 401 response is received, refresh the access token

    //   String? newAccessToken = await refreshToken();
    //   if (newAccessToken != null) {
    //     _dio.options.headers['Authorization'] = 'Bearer $newAccessToken';
    //     return handler.resolve(await _dio.fetch(err.requestOptions));
    //   }

    //   // Update the request header with the new access token
    //   // err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

    //   // Repeat the request with the updated header
    // }
    return handler.next(err);
  }

  /// Refresh Token
  // Future<String?> refreshToken() async {
  //   try {
  //     var key = ApiEndpoints.instance;
  //     String? token = await storage.readData(key.refreshToken);
  //     String? pin = await storage.readData(key.unlockPass);

  //     log("${_dio.options.headers}");

  //     final res = await _dio.post(
  //       key.changeUnlockPin,
  //       data: {"pin": pin, "refresh": token},
  //     );
  //     log("${res.data}");

  //     storage.saveData(key.token, res.data["data"]["tokens"]["access"]);
  //     storage.saveData(key.refreshToken, res.data["data"]["tokens"]["refresh"]);
  //     return res.data["data"]["tokens"]['access'];
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  bool shouldRefresh<R>(Response<R> response) => response.statusCode == 401;

  Future<bool> retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    await _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
    return true;
  }
}

class TokenExpiration {
  static int getExpiration(String token) {
    // var key = ApiEndpoints.instance;
    // String? token = await SecureStorage.readData(key.token);
    // Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    // int expirationTimeInSeconds = decodedToken["exp"];
    // int currentTimeInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    // int timeDifferenceInSeconds =
    //     expirationTimeInSeconds - currentTimeInSeconds;
    // int timeDifferenceInMinutes = timeDifferenceInSeconds ~/ 60;

    // log("Token Expiration Time in Minutes: $timeDifferenceInMinutes");

    return -60;
  }
}
