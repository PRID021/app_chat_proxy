import 'package:app_chat_proxy/dev/logger.dart';
import 'package:app_chat_proxy/router/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'di.dart';
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
        final userReferences = ref.watch(userReferencesNotifierProvider);
        if (userReferences.isDarkMode == true) {
          themeMode = ThemeMode.dark;
        }
        if (userReferences.isDarkMode == false) {
          themeMode = ThemeMode.light;
        }
        if (userReferences.isDarkMode == null) {
          themeMode = ThemeMode.system;
        }
        logger.d(userReferences.isDarkMode);
        return MaterialApp.router(
          routerConfig: ref.watch(appRouterProvider).config(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          themeMode: themeMode,
          locale: userReferences.locale,
          darkTheme: ThemeData.dark(),
          builder: (context, child) {
            return KeyedSubtree(
              key: ref.read(appKeysProvider).routeKey,
              child: child ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}
