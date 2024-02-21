import 'dart:convert';

import 'package:app_chat_proxy/core/common/result.dart';
import 'package:app_chat_proxy/core/network/http_method.dart';
import 'package:app_chat_proxy/domain/entities/token.dart';

import '../../../core/network/sender.dart';

class AuthParse implements DataParser<Token, dynamic> {
  @override
  Token fromSource({required rawSource}) {
    final json = jsonDecode(rawSource.toString());
    return Token(
        accessToken: json["access_token"], tokenType: json["access_token"]);
  }
}

class AuthApi {
  final Sender _sender;

  AuthApi({required Sender sender}) : _sender = sender;

  Future<Result<Object, Token>> authenticate(
      String userName, String password) async {
    final rs = await _sender.sendApiRequest<Object, Token>(
      method: HttpMethod.post,
      dataParser: AuthParse(),
      body: {
        'grant_type': '',
        'username': userName,
        'password': password,
        'scope': '',
        'client_id': '',
        'client_secret': ''
      },
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );
    return rs;
  }
}
