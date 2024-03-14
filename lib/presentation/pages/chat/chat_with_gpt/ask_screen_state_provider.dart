import 'package:app_chat_proxy/presentation/pages/chat/chat_with_gpt/states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AskScreenStateNotifier extends Notifier<AskScreenState> {
  @override
  AskScreenState build() {
    return const InitState();
  }

  void loadingMessageHistory() async {}
}
