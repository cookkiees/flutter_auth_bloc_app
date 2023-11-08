import 'dart:convert';

import 'package:authentication_with_bloc_app/app/data/local_storage.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants/app_constants.dart';
import '../helpers/app_logger.dart';
import 'service_api_result.dart';
import 'service_api_result_type.dart';
import 'service_api_request.dart';

class ApiService {
  static final ApiService _instance = ApiService._privateConstructor();
  ApiService._privateConstructor();
  static ApiService get instance {
    return _instance;
  }

  Future<ApiResult<T>> request<T>(ApiRequest<T> request,
      {bool isJsonEncode = false, bool withAuthorization = false}) async {
    final uri = _buildUrl(request.path, request.params);
    final headers = request.headers;
    if (withAuthorization == true) {
      final authorization = await LocalStorage.getStringToken();
      headers?['Authorization'] = 'Bearer $authorization';
    }
    http.Response response;

    try {
      switch (request.method) {
        case 'GET':
          response = await http.get(uri, headers: headers);
          break;
        case 'POST':
          if (isJsonEncode == true) {
            response = await http.post(uri,
                body: jsonEncode(request.params), headers: headers);
          } else {
            response =
                await http.post(uri, body: request.params, headers: headers);
          }

          break;
        case 'PUT':
          response =
              await http.put(uri, body: request.params, headers: headers);
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: headers);
          break;
        default:
          response = await http.get(uri, headers: headers);
      }
      debugPrint(request, headers, response);
      if (response.statusCode == 200) {
        var decodedJson = jsonDecode(response.body);
        var data = request.decoder(decodedJson);

        if (decodedJson['code'] == 1) {
          return ApiResult<T>(
            result: ApiResultType.failure,
            message: decodedJson['message'],
          );
        }

        if (data == null || (data is List && data.isEmpty)) {
          return ApiResult<T>(
            result: ApiResultType.failure,
            message: "Data is empty or null",
          );
        } else {
          return ApiResult<T>(
            result: ApiResultType.success,
            message: "Successful",
            data: data,
          );
        }
      } else {
        return ApiResult(
          result: ApiResultType.failure,
          message: 'Failure',
        );
      }
    } catch (e) {
      return ApiResult(
        result: ApiResultType.failure,
        message: 'Failure: $e',
      );
    }
  }

  Uri _buildUrl(String path, Map<String, dynamic>? params) {
    final url = Uri.parse(apiBaseURL + apiVersion + path);
    if (params != null && params.isNotEmpty) {
      return url.replace(queryParameters: params);
    }
    return url;
  }

  Future<void> debugPrint(
      ApiRequest request, headers, http.Response response) async {
    AppLogger.logDebug('--------------- REQUEST & RESPONSE ---------------');
    AppLogger.logDebug('Method: ${request.method}');
    AppLogger.logDebug('Path: ${response.request?.url.toString()}');
    AppLogger.logDebug('Headers: $headers');
    AppLogger.logDebug('Parameters: ${request.params}');
    AppLogger.logDebug('Status: ${response.statusCode}');
    AppLogger.logDebug('Headers: ${response.headers}');
    AppLogger.logDebug('Response Body: ${response.body}');
    AppLogger.logDebug('--------------------------------------------------');
  }
}
