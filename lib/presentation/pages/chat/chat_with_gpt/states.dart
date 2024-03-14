import 'models/message.dart';

abstract class AskScreenState {
  const AskScreenState();
}

class InitState extends AskScreenState {
  const InitState();
}

class InConversationState extends AskScreenState {
  final List<Message> messages;

  const InConversationState({required this.messages});
}
