import 'package:app_chat_proxy/application/utils/l10n_ext.dart';
import 'package:app_chat_proxy/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(context.appLocalizations.welcomeOnBoard),
          ),
          ElevatedButton(
            onPressed: () => context.router.replaceAll([const LoginRoute()]),
            child: Text(context.appLocalizations.signIn),
          ),
        ],
      ),
    );
  }
}
