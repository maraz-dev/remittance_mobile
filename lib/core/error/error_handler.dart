import 'package:dio/dio.dart';
import 'package:remittance_mobile/core/error/error_model.dart';
import 'package:remittance_mobile/core/error/http_error_strings.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = HttpErrorStrings.operationCancelled;
        break;
      case DioExceptionType.connectionError:
        message = HttpErrorStrings.connectionTimeoutActive;
        break;
      case DioExceptionType.receiveTimeout:
        message = HttpErrorStrings.receiveTimeout;
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = HttpErrorStrings.sendTimeout;
        break;
      case DioExceptionType.unknown:
        if (dioError.error.toString().contains("SocketException")) {
          message = HttpErrorStrings.genericRes;
          break;
        }
        message = HttpErrorStrings.uknown;
        break;
      default:
        message = "Something Went Wrong. Please Try Again Later";
        break;
    }
  }
  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return handleError(error);
      case 401:
        return "Please Login Again!";
      case 413:
        return error["message"];
      case 424:
        return error["error"]["message"];
      case 403:
        // FailureRes result = FailureRes.fromJson(error);
        return "Error Occurred";
      case 404:
        return "An Error Occured";
      case 500:
        return "An Error Occurred. Try again later";
      case 502:
        return "Bad Gateway";
      case 503:
        return "Service Unavailable";
      case 504:
        return "Service Unavaiilable. Please Try Again Later";
      default:
        return "$statusCode: Oops Something Went Wrong";
    }
  }

  String handleError(dynamic error) {
    if (error["errors"] != null) {
      FailureRes result = FailureRes.fromJson(error);
      if (result.error.phoneNumber!.isNotEmpty) {
        return result.error.phoneNumber.toString();
      } else if (result.error.message!.isNotEmpty) {
        return result.error.message.toString();
      } else if (result.error.email!.isNotEmpty) {
        return result.error.email.toString();
      } else if (result.error.firstName!.isNotEmpty) {
        return result.error.firstName.toString();
      } else if (result.error.lastName!.isNotEmpty) {
        return result.error.lastName.toString();
      } else if (result.err.isNotEmpty) {
        return result.err.toString();
      } else if (result.error.amount!.isNotEmpty) {
        return result.error.amount.toString();
      } else if (result.error.transactionPin!.isNotEmpty) {
        return result.error.transactionPin.toString();
      } else if (result.error.username!.isNotEmpty) {
        return result.error.username.toString();
      } else if (result.error.password!.isNotEmpty) {
        return result.error.password.toString();
      } else if (result.error.code!.isNotEmpty) {
        return result.error.code.toString();
      } else if (result.error.token!.isNotEmpty) {
        return result.error.token.toString();
      } else if (result.error.recipient!.isNotEmpty) {
        return 'User does not Exist';
      } else if (result.message.isNotEmpty) {
        return result.message.toString();
      } else {
        return error["message"];
      }
    } else {
      return "An Error Occurred";
    }
  }

  @override
  String toString() => message;
}
