import 'dart:convert';

import 'package:app_chat_proxy/domain/entities/conversation_message.dart';
import 'package:dio/dio.dart';

import '../../../../core/common/result.dart';
import '../../../../core/network/http_method.dart';
import '../../../../core/network/sender.dart';
import '../../../../domain/entities/conversation.dart';
import '../../../../domain/entities/conversation_role.dart';

abstract class ChatApi {
  Future<Result<Object, List<Conversation>>> getUserConversations();

  Future<Result<Object, List<ConversationMessage>>> getConversationMessages(
      {required int conversationId});

  Future<Result<Object, Stream<String>>> postConversationMessage(
      {required int conversationId, required String content});
}

class ConversationsParser implements DataParser<List<Conversation>, List> {
  @override
  List<Conversation> fromSource({required json}) {
    return json.map((e) {
      return Conversation(id: e['id'], title: e['title']);
    }).toList();
  }
}

class ConversationRoleParse implements DataParser<ConversationRole, int> {
  @override
  ConversationRole fromSource({required int json}) {
    if (json == 0) {
      return ConversationRole.hu;
    }
    return ConversationRole.ai;
  }
}

class ConversationMessagesParser
    implements DataParser<List<ConversationMessage>, List> {
  @override
  List<ConversationMessage> fromSource({required List json}) {
    return json.map((e) {
      return ConversationMessage(
        sender: ConversationRoleParse().fromSource(json: e["sender"]),
        id: e["id"],
        conversationId: e["conversation_id"],
        createdAt: DateTime.parse(e["created_at"]),
        content: StringBuffer(
          e["content"],
        ),
      );
    }).toList();
  }
}

class BotMessageStreamParser
    implements DataParser<Stream<String>, ResponseBody> {
  @override
  Stream<String> fromSource({required ResponseBody json}) {
    return utf8.decoder.bind(json.stream);
  }
}

class ChatApiImp implements ChatApi {
  final Sender _sender;

  ChatApiImp({required Sender sender}) : _sender = sender;

  @override
  Future<Result<Object, List<Conversation>>> getUserConversations() async {
    final rs = await _sender.sendApiRequest(
      method: HttpMethod.get,
      dataParser: ConversationsParser(),
      pathParameter: "/conversation",
    );
    return rs;
  }

  @override
  Future<Result<Object, List<ConversationMessage>>> getConversationMessages(
      {required int conversationId}) async {
    final rs = await _sender.sendApiRequest(
      method: HttpMethod.get,
      dataParser: ConversationMessagesParser(),
      pathParameter: "/conversation/$conversationId",
    );
    return rs;
  }

  @override
  Future<Result<Object, Stream<String>>> postConversationMessage(
      {required int conversationId, required String content}) async {
    final rs = await _sender.sendApiRequest(
        method: HttpMethod.get,
        dataParser: BotMessageStreamParser(),
        headers: {"accept": "text/event-stream"},
        responseType: ResponseType.stream,
        queryParameters: {
          "conversation_id": conversationId,
          "message": content
        });
    return rs;
  }
}
