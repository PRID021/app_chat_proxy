import 'package:app_chat_proxy/data/repositories/chat_repository/di.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'states.dart';

final chatHistoryScreenStateNotifierProvider =
    NotifierProvider<HistoryScreenStateNotifier, HistoryScreenState>(
  () {
    return HistoryScreenStateNotifier();
  },
);

class HistoryScreenStateNotifier extends Notifier<HistoryScreenState> {
  @override
  HistoryScreenState build() {
    return const InitState();
  }

  Future loadUserConversations() async {
    state = const LoadingState();
    final chatRepository = ref.read(chatRepositoryProvider);
    final rs = await chatRepository.getUserConversations();
    if (rs != null) {
      state = LoadingDone(conversations: rs);
    } else {
      state = ErrorState(
        extendData:
            Exception("Unknown error happened, Please try again later!"),
      );
    }
  }
}
