import 'package:app_chat_proxy/core/common/result.dart';
import 'package:app_chat_proxy/core/network/http_method.dart';
import 'package:app_chat_proxy/domain/entities/token.dart';

import '../../../core/network/sender.dart';

class AuthApi {
  final Sender sender;

  AuthApi({required this.sender});

  Future<Result<Object, Token>> authenticate(
      String userName, String password) async {
    // return Result.failure("ER");

    return sender.sendApiRequest<Object, Token>(
      method: HttpMethod.post,
      body: {
        'username': userName,
        'password': password,
      },
    );
  }
}
