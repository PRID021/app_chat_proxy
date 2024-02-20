import 'package:dio/dio.dart';

import '../../../core/common/environment.dart';
import '../../../core/network/http_api_config.dart';

class AuthHttpApiConfig implements HttpApiConfig {
  @override
  Dio createDio() {
    final options = BaseOptions(
        connectTimeout: const Duration(seconds: 10000),
        receiveTimeout: const Duration(seconds: 10000),
        baseUrl: appEnv.getData());
    return Dio(options);
  }

  @override
  // TODO: implement path
  String get path => "/token";
}
