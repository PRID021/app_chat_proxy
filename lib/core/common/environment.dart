Environment currentEnvironment = Environment.dev;

enum Environment { dev, stg, prod }

abstract class EnvironmentData<D> {
  D dev();

  D stg();

  D prod();

  D getData() {
    switch (currentEnvironment) {
      case Environment.dev:
        return dev();
      case Environment.stg:
        return stg();
      case Environment.prod:
        return prod();
    }
  }
}

final appEnv = AppEnvironmentData();

class AppEnvironmentData extends EnvironmentData<String> {
  @override
  String dev() {
    return "http://192.168.1.40:14433";
  }

  @override
  String prod() {
    // TODO: implement prod
    throw UnimplementedError();
  }

  @override
  String stg() {
    // TODO: implement stg
    throw UnimplementedError();
  }
}
