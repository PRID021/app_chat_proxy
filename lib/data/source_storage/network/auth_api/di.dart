import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/http_error.dart';
import '../../../../core/network/internet_supervisor.dart';
import '../../../../core/network/sender.dart';
import '../../../../presentation/pages/login/authenticate_provider.dart';
import 'auth_api.dart';

final authApiProvider = Provider(
  (ref) => AuthApiImp(
    sender: Sender(
      internetSupervisor: ref.watch(internetSupervisorProvider),
      httpApiConfig: AuthHttpApiConfig(path: "/token"),
      errorProcessing: ref.read(errorProcessingProvider),
    ),
  ),
);
