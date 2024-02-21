import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/environment.dart';
import '../../../core/network/http_api_config.dart';
import '../../../data/repositories/auth_repository/di.dart';
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

final authenticateNotifierProvider =
    NotifierProvider<AuthenticateNotifier, AuthStatus>(() {
  return AuthenticateNotifier();
});

class AuthenticateNotifier extends Notifier<AuthStatus> {
  @override
  AuthStatus build() {
    final authRepository = ref.read(authRepositoryProvider);
    final token = authRepository.storageToken();
    if (token == null) {
      return AuthStatus.unAuthenticate;
    }
    return AuthStatus.authenticated;
  }

  void performAuthenticate(
      {required String userName, required String password}) async {
    final authRepository = ref.read(authRepositoryProvider);
    final rs = await authRepository.authenticate(
        userName: userName, password: password);
    logger.w(rs);
    if (rs != null) {
      state = AuthStatus.authenticated;
    } else {
      state = AuthStatus.unAuthenticate;
    }
  }

  void clearStorage() {
    ref.read(authRepositoryProvider).clearStorage().then((value) {
      state = AuthStatus.unAuthenticate;
    });
  }
}
