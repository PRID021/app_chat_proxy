import '../../../../core/common/result.dart';
import '../../../../core/network/http_method.dart';
import '../../../../core/network/sender.dart';
import '../../../../domain/entities/conversation.dart';

abstract class ChatApi {
  Future<Result<Object, List<Conversation>>> getUserConversations();
}

class ConversationsParser implements DataParser<List<Conversation>, List> {
  @override
  List<Conversation> fromSource({required rawSource}) {
    return rawSource.map((e) {
      return Conversation(id: e['id'], title: e['title']);
    }).toList();
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
}
