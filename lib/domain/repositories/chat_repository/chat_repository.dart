import '../../entities/conversation.dart';

abstract class ChatRepository {
  Future<List<Conversation>?> getUserConversations();
}
