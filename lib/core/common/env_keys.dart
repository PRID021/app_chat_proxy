import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvKeys {
  static String host = "HOST";
  static String scheme = "SCHEME";
}

class EnvironmentLoader {
  static late String host;
  static late String scheme;

  EnvironmentLoader._internal();

  static void load(DotEnv dotEnv) {
    host = dotEnv.env[EnvKeys.host]!;
    scheme = dotEnv.env[EnvKeys.scheme]!;
  }
}
