import 'package:remittance_mobile/core/http/http_service.dart';
import 'package:remittance_mobile/core/http/response_body_handler.dart';
import 'package:remittance_mobile/core/utils/app_url.dart';
import 'package:remittance_mobile/data/models/responses/customer_transaction_model.dart';
import 'package:remittance_mobile/data/models/responses/transaction_detail_model.dart';

class TransactionsService {
  final HttpService _networkService;

  TransactionsService({required HttpService networkService}) : _networkService = networkService;

  // Endpoint URL Instance
  final endpointUrl = ApiEndpoints.instance;

  // Class to Handle API Response
  final ResponseHandler _responseHandler = ResponseHandler();

  // Get Customer Transaction Endpoint
  Future<List<TransactionsRes>> getCustomerTransactions() async {
    try {
      final response = await _networkService.request(
          endpointUrl.baseFundingUrl + endpointUrl.getCustomerTransactions, RequestMethod.post,
          data: {
            "pageNumber": 1,
            "pageSize": 1000,
            "startDate": null,
            "EndDate": null,
          });

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data']["result"] as List;
          final responseList = res.map((json) => TransactionsRes.fromJson(json)).toList();
          return responseList;
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  // Get Customer Transaction Details
  Future<TransactionDetailRes> getTransactionDetail(String requestId) async {
    try {
      final response = await _networkService.request(
        "${endpointUrl.baseFundingUrl}${endpointUrl.getTransactionDetails}?requestId=$requestId",
        RequestMethod.get,
      );

      // Handle the Response
      final result = _responseHandler.handleResponse(
        response: response.data,
        onSuccess: () {
          final res = response.data['data'];
          return TransactionDetailRes.fromJson(res);
        },
      );
      return result;
    } catch (e) {
      throw e.toString();
    }
  }
}
