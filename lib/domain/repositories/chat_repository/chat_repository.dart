import 'package:app_chat_proxy/domain/entities/conversation_message.dart';

import '../../entities/conversation.dart';

abstract class ChatRepository {
  Future<List<Conversation>?> getUserConversations();
  Future<List<ConversationMessage>?> getConversationMessages(
      int conversationId);
}
