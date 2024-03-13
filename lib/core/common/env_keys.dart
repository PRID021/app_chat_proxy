import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  static void load(DotEnv dotEnv) {
    host = dotEnv.env[EnvKeys.host]!;
    scheme = dotEnv.env[EnvKeys.scheme]!;
    geminiHost = dotEnv.env[EnvKeys.geminiHost]!;
    geminiPort = int.parse(dotEnv.env[EnvKeys.geminiPort]!);
    geminiScheme = dotEnv.env[EnvKeys.geminiScheme]!;
  }
}
