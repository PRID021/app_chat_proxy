import 'package:app_chat_proxy/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../di.dart';
import 'authenticate_provider.dart';

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userReferences = ref.watch(userReferencesNotifierProvider);
    final userController = TextEditingController();
    final passwordController = TextEditingController();

    final notifier = ref.listen(authenticateProvider, (pre, next) {
      if (next == AuthStatus.authenticated) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$next')));
        context.router.replaceAll([const HomeRoute()]);
      }
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final notifier = ref.watch(authenticateProvider);
            return Text(notifier.toString());
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: userController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const Gap(8),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final authNotifier =
                        ref.read(authenticateProvider.notifier);
                    authNotifier.performAuthenticate(
                        userName: userController.text,
                        password: passwordController.text);
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
