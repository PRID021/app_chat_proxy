import 'dart:convert';

import '../../../../core/common/result.dart';
import '../../../../core/network/http_method.dart';
import '../../../../core/network/sender.dart';
import '../../../../domain/entities/conversation.dart';

abstract class ChatApi {
  Future<Result<Object, List<Conversation>>> userConversations();
}

class ConversationsParser implements DataParser<List<Conversation>, dynamic> {
  @override
  List<Conversation> fromSource({required rawSource}) {
    final json = jsonDecode(rawSource.toString()) as List;
    return json.map((e) {
      return Conversation(id: e['id'], title: e['title']);
    }).toList();
  }
}

class ChatApiImp implements ChatApi {
  final Sender _sender;

  ChatApiImp({required Sender sender}) : _sender = sender;

  @override
  Future<Result<Object, List<Conversation>>> userConversations() async {
    final rs = await _sender.sendApiRequest(
        method: HttpMethod.get,
        dataParser: ConversationsParser(),
        pathParameter: "/conversation");
    return rs;
  }
}
