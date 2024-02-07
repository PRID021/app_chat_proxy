import 'package:app_chat_proxy/application/utils/l10n_ext.dart';
import 'package:app_chat_proxy/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class OnBoardScreen extends ConsumerStatefulWidget {
  const OnBoardScreen({super.key});

  @override
  ConsumerState<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends ConsumerState<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context,ref,child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(context.appLocalizations(ref).welcomeOnBoard),
              ),
              ElevatedButton(
                onPressed: () => context.router.replaceAll([const LoginRoute()]),
                child: Text(context.appLocalizations(ref).signIn),
              ),
            ],
          );
        }
      ),
    );
  }
}
