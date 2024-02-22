import 'package:app_chat_proxy/dev/logger.dart';
import 'package:app_chat_proxy/presentation/pages/login/authenticate_provider.dart';
import 'package:app_chat_proxy/router/app_router.dart';
import 'package:app_chat_proxy/router/di.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'di.dart';
import 'eager_initialization.dart';
import 'firebase_options.dart';

final analyticsProvider = Provider((ref) => FirebaseAnalytics.instance);
late final PackageInfo packageInfo;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  packageInfo = await PackageInfo.fromPlatform();
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final analytics = FirebaseAnalytics.instanceFor(app: app);
  final analyticsProvider = Provider((ref) => analytics);
  await SentryFlutter.init((options) {
    options.dsn =
        'https://3ed1a9d63b4f1fec38f7592845d15296@o4506788251893760.ingest.sentry.io/4506788288004096';
    // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
    // We recommend adjusting this value in production.
    options.tracesSampleRate = 1.0;
  },
      appRunner: () => runApp(
            ProviderScope(
              overrides: [analyticsProvider],
              child: const MyApp(),
            ),
          ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return EagerInitialization(
      key: ref.read(appKeysProvider).appKey,
      builder: (context, ref) {
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
        final authStatus = ref.watch(authenticateNotifierProvider);
        return MaterialApp.router(
          routerConfig: ref.watch(appRouterProvider).config(
              initialRoutes: authStatus == AuthStatus.authenticated
                  ? [const HomeRoute()]
                  : []),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          themeMode: themeMode,
          locale: userReferences.locale,
          darkTheme: ThemeData.dark(),
          builder: (context, child) {
            return KeyedSubtree(
              child: Consumer(
                  child: child,
                  builder: (context, ref, child) {
                    ref.listen(authenticateNotifierProvider, (_, authStatus) {
                      if (authStatus == AuthStatus.unAuthenticate) {
                        ref
                            .read(appKeysProvider)
                            .navKey
                            ?.currentContext!
                            .router
                            .replaceAll([const LoginRoute()]);
                      }
                      logger.w("Auth Status Changed");
                    });
                    return child ?? const SizedBox.shrink();
                  }),
            );
          },
        );
      },
    );
  }
}
