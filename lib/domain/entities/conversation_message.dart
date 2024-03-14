import 'package:app_chat_proxy/domain/entities/conversation_role.dart';

class ConversationMessage {
  final ConversationRole sender;
  final int id;
  final int conversationId;
  final DateTime createdAt;
  final StringBuffer content;

  ConversationMessage({
    required this.sender,
    required this.id,
    required this.conversationId,
    required this.createdAt,
    required this.content,
  });
}
