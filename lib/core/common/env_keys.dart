import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvKeys {
  static String host = "HOST";
  static String port = "PORT";
  static String scheme = "SCHEME";
}

class EnvironmentLoader {
  static late String host;
  static late int port;
  static late String scheme;

  EnvironmentLoader._internal();

  static void load(DotEnv dotEnv) {
    host = dotEnv.env[EnvKeys.host]!;
    port = int.parse(dotEnv.env[EnvKeys.port]!);
    scheme = dotEnv.env[EnvKeys.scheme]!;
  }
}
