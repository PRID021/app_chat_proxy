import 'dart:async';
import 'dart:convert';

import 'package:app_chat_proxy/application/utils/di.dart';
import 'package:app_chat_proxy/router/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'domain/repositories/user_repository/di.dart';
import 'eager_initialization.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EagerInitialization(
      builder: (context, _) {
        late ThemeMode themeMode;
        final isDarkMode =
            ref.watch(userReferenceRepositoryProvider).isDarkMode();
        if (isDarkMode == true) {
          themeMode = ThemeMode.dark;
        }
        if (isDarkMode == false) {
          themeMode = ThemeMode.light;
        }
        if (isDarkMode == null) {
          themeMode = ThemeMode.system;
        }
        return MaterialApp.router(
          key: ref.read(appKeysProvider).appKey,
          routerConfig: ref.watch(appRouterProvider).config(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          themeMode: themeMode,
          darkTheme: ThemeData.dark(),
          builder: (context, child) {
            return KeyedSubtree(
              key: ref.read(appKeysProvider).routeKey,
              child: child!,
            );
          },
        );
      },
    );
  }
}

class QuestionAnswer {
  final String question;
  final StringBuffer answer;

  QuestionAnswer({required this.question, required this.answer});
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<QuestionAnswer> conversationChats = [];
  final TextEditingController textEditingController = TextEditingController();

  void requestAnswer() async {
    String question = textEditingController.text;

    setState(() {
      textEditingController.clear();
    });
    if (question.isEmpty) {
      return;
    }
    final requestModel =
        QuestionAnswer(question: question, answer: StringBuffer());
    conversationChats.add(requestModel);
    final request = http.StreamedRequest(
      "GET",
      Uri(
          scheme: "http",
          host: "192.168.1.167",
          port: 14433,
          path: "/chat",
          queryParameters: {"message": question}),
    );
    unawaited(request.sink.close());
    final response = await request.send();
    response.stream.listen((value) {
      setState(() {
        final chunk = utf8.decode(value);
        requestModel.answer.write(chunk);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, idx) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text("Q:"),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.purpleAccent.withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  conversationChats[idx].question,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 32,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(8)),
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                "${conversationChats[idx].answer}",
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 8, left: 8),
                            child: Text("BOT"),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: conversationChats.length,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            decoration: const BoxDecoration(color: Colors.grey),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: textEditingController,
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                IconButton(
                  iconSize: 24,
                  color: Colors.blue,
                  onPressed: requestAnswer,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
