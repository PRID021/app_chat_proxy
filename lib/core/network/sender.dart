import 'package:app_chat_proxy/core/network/http_api_config.dart';
import 'package:app_chat_proxy/core/network/http_method.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../common/result.dart';
import 'http_error.dart';
import 'internet_supervisor.dart';

class Sender {
  final InternetSupervisor internetSupervisor;
  final HttpApiConfig httpApiConfig;
  final ErrorProcessing errorProcessing;

  Sender({
    required this.internetSupervisor,
    required this.httpApiConfig,
    required this.errorProcessing,
  });

  @protected
  Future<Result<F, S>> sendApiRequest<F extends Object, S extends Object>({
    required HttpMethod method,
    Map<String, String>? headers,
    dynamic body,
    Map<String, dynamic> queryParameters = const {},
    ResponseType responseType = ResponseType.json,
    Options? options,
  }) async {
    final dio = httpApiConfig.createDio();
    late Future<Response>? response;
    if (method == HttpMethod.post) {
      response = dio.post(httpApiConfig.path,
          data: body, queryParameters: queryParameters, options: options);
    } else if (method == HttpMethod.get) {
      response = dio.get(httpApiConfig.path,
          queryParameters: queryParameters, options: options);
    } else if (method == HttpMethod.delete) {
      response = dio.delete(httpApiConfig.path,
          queryParameters: queryParameters, options: options);
    } else if (method == HttpMethod.put) {
      response = dio.put(httpApiConfig.path,
          data: body, queryParameters: queryParameters, options: options);
    }
    if (response == null) {
      throw UnsupportedError("$method not supported");
    }
    return response.then((value) {
      return Result.success(value as S);
    }, onError: (error) {
      return Result.failure(errorProcessing.handlerError(error));
    });
  }
}
