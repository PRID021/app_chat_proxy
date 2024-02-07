import 'package:app_chat_proxy/domain/repositories/user_repository/di.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text("Switch theme mode"),
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return Switch(
                value:
                    ref.watch(userReferenceRepositoryProvider).isDarkMode() ??
                        false,
                onChanged: (value) async {
                  print(value);
                  ref
                      .read(userReferenceRepositoryProvider)
                      .setUserReferMode(value);
                },
              );
            },
          )
        ],
      ),
    );
  }
}
