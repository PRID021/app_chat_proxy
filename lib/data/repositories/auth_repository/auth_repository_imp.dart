import 'package:app_chat_proxy/core/common/result.dart';
import 'package:app_chat_proxy/domain/entities/token.dart';

import '../../../domain/repositories/auth_repository/auth_repository.dart';
import '../../remote/auth_api/auth_api.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthApi api;

  AuthRepositoryImp(this.api);

  @override
  Future<Token?> authenticate(
      {required String userName, required String password}) async {
    final rs = await api.authenticate(userName, password);
    if (rs is Success) {
      return rs.getOrThrow();
    } else {
      return null;
    }
  }
}
