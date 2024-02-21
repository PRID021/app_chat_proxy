import 'package:app_chat_proxy/core/common/environment.dart';
import 'package:app_chat_proxy/core/common/result.dart';
import 'package:app_chat_proxy/data/remote/auth_api/auth_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/http_api_config.dart';
import '../../../core/network/http_error.dart';
import '../../../core/network/internet_supervisor.dart';
import '../../../core/network/sender.dart';
import '../../../dev/logger.dart';

enum AuthStatus {
  unAuthenticate,
  authenticated,
}

class AuthHttpApiConfig extends HttpApiConfig {
  AuthHttpApiConfig({required super.path});

  @override
  Dio createDio() {
    final options = BaseOptions(baseUrl: appEnv.getData());
    return Dio(options);
  }
}

final authApiProvider = Provider(
  (ref) => AuthApi(
    sender: Sender(
      internetSupervisor: ref.watch(internetSupervisorProvider),
      httpApiConfig: AuthHttpApiConfig(path: "/token"),
      errorProcessing: ref.read(errorProcessingProvider),
    ),
  ),
);

final authenticateProvider =
    NotifierProvider<AuthenticateNotifier, AuthStatus>(() {
  return AuthenticateNotifier();
});

class AuthenticateNotifier extends Notifier<AuthStatus> {
  @override
  AuthStatus build() {
    return AuthStatus.unAuthenticate;
  }

  void performAuthenticate(
      {required String userName, required String password}) async {
    final authApi = ref.read(authApiProvider);
    final rs = await authApi.authenticate(userName, password);
    logger.w(53);
    if (rs is Success) {
      logger.w(rs);
      state = AuthStatus.authenticated;
    } else {
      state = AuthStatus.unAuthenticate;
    }
  }
}
