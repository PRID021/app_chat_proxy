import 'package:app_chat_proxy/router/app_router.dart';
import 'package:app_chat_proxy/utils/l10n_ext.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../main.dart';

@RoutePage()
class OnBoardScreen extends ConsumerStatefulWidget {
  const OnBoardScreen({super.key});

  @override
  ConsumerState<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends ConsumerState<OnBoardScreen> {
  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(builder: (context, ref, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Align(
                  alignment: Alignment.center,
                  child:
                      // Text(context.appLocalizations(ref).welcomeOnBoard)
                      //     .animate()
                      //     .tint(color: Colors.purple),
                      Text("Horrible Pulsing Text")
                          .animate(
                              onPlay: (controller) =>
                                  controller.repeat(reverse: true))
                          .fadeOut(curve: Curves.easeInOut)),
              ElevatedButton(
                onPressed: () {
                  context.router.replaceAll([const LoginRoute()]);
                },
                child: Text(context.appLocalizations(ref).signIn),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [Text("$appName  - version: $version ")],
              )
            ],
          );
        }),
      ),
    );
  }
}
