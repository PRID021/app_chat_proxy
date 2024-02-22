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

  Widget title = const Text(
    'Welcome to on board with us.',
    style: TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 28,
      color: Color(0xFF666870),
      height: 1,
      letterSpacing: -1,
    ),
  );

  // here's an interesting little trick, we can nest Animate to have
  // effects that repeat and ones that only run once on the same item:

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(builder: (context, ref, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 2,
              ),
              Align(
                  alignment: Alignment.center,
                  child: title
                      .animate(onPlay: (controller) => controller.repeat())
                      .shimmer(
                          duration: 1200.ms, color: const Color(0xFF80DDFF))
                      .animate() // this wraps the previous Animate in another Animate
                      .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
                      .slide()),
              const Spacer(
                flex: 1,
              ),
              ElevatedButton(
                onPressed: () {
                  context.router.replaceAll([const LoginRoute()]);
                },
                child: Text(context.appLocalizations(ref).signIn),
              ),
              const Spacer(),
              Text(initialLink ?? "Normal Launch"),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [Text("$appName  - version: $version")],
              )
            ],
          );
        }),
      ),
    );
  }
}
