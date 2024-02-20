import 'package:dio/src/dio.dart';

import '../../../core/network/http_api_config.dart';

class AuthApiConfig extends HttpApiConfig {
  AuthApiConfig({required super.path});

  @override
  Dio createDio() {
    // TODO: implement createDio
    throw UnimplementedError();
  }
}
