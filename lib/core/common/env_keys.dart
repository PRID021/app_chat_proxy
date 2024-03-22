import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../dev/logger.dart';

class EnvKeys {
  static String host = "HOST";
  static String scheme = "SCHEME";
  static String geminiHost = "GEMINI_HOST";
  static String geminiPort = "GEMINI_PORT";
  static String geminiScheme = "GEMINI_SCHEME";
}

class EnvironmentLoader {
  static late String host;
  static late String scheme;

  static late String geminiHost;
  static late int geminiPort;
  static late String geminiScheme;

  EnvironmentLoader._internal();

  static Future<void> load(DotEnv dotEnv) async {
    host = dotEnv.env[EnvKeys.host]!;
    scheme = dotEnv.env[EnvKeys.scheme]!;
    geminiHost = dotEnv.env[EnvKeys.geminiHost]!;
    geminiPort = int.parse(dotEnv.env[EnvKeys.geminiPort]!);
    geminiScheme = dotEnv.env[EnvKeys.geminiScheme]!;
    if (kDebugMode) {
      host = const String.fromEnvironment('HOST_BUILD_IP',
          defaultValue: 'SOME_DEFAULT_VALUE');
      geminiHost = host;
      host = "$host:8080";
      logger.w("Build debug on pc ip: $host");
    }
  }
}
