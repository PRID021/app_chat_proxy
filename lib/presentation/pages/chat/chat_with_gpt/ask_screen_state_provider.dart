import 'package:app_chat_proxy/core/common/errors.dart';
import 'package:app_chat_proxy/data/repositories/chat_repository/di.dart';
import 'package:app_chat_proxy/presentation/pages/chat/chat_with_gpt/states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final askScreenStateNotifierProvider =
    NotifierProvider.family<AskScreenStateNotifier, AskScreenState, int>(
        AskScreenStateNotifier.new);

class AskScreenStateNotifier extends FamilyNotifier<AskScreenState, int> {
  late int conversationId;

  AskScreenStateNotifier();

  void loadingMessageHistory() async {
    final messages = await ref
        .read(chatRepositoryProvider)
        .getConversationMessages(conversationId);
    if (messages != null) {
      state = InConversationState(messages: messages!);
    } else {
      state = ErrorState(
        const UnknownError("Some error happened please try again later."),
      );
    }
  }

  @override
  build(arg) {
    conversationId = arg;
    return const InitState();
  }
}
