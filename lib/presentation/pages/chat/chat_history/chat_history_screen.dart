import 'package:app_chat_proxy/dev/logger.dart';
import 'package:app_chat_proxy/presentation/common/components/common_app_bar.dart';
import 'package:app_chat_proxy/presentation/pages/chat/chat_history/states.dart';
import 'package:app_chat_proxy/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/components/wild_card.dart';
import 'chat_history_state_provider.dart';

@RoutePage()
class ChatHistoryScreen extends ConsumerStatefulWidget {
  const ChatHistoryScreen({super.key});

  @override
  ConsumerState<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends ConsumerState<ChatHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(chatHistoryScreenStateNotifierProvider.notifier)
          .loadUserConversations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatHistoryScreenStateNotifierProvider);
    Widget? body;
    if (state is LoadingState) {
      body = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is LoadingDone) {
      body = Center(
        child: ListView.builder(
            itemCount: state.conversations.length,
            itemBuilder: (ctx, idx) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  onTap: () async {
                    try {
                      await context.router.push(
                        AskRoute(conversationId: state.conversations[idx].id),
                      );
                    } catch (e) {
                      logger.e(e);
                    }
                  },
                  title: Text(state.conversations[idx].id.toString()),
                  leading: const Icon(Icons.message),
                  subtitle: Text(
                    state.conversations[idx].title,
                  ),
                ),
              );
            }),
      );
    }
    if (state is ErrorState) {
      body = ErrorWidget(state.extendData);
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(ChatRoute(title: "Chat With Gemini"));
        },
        child: const Icon(Icons.question_answer_outlined),
      ),
      appBar: const CommonAppBar(
        title: Text("Recently conversations"),
      ),
      body: body ?? const WildCard(),
    );
  }
}
