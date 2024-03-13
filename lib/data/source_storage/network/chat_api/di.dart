import 'package:app_chat_proxy/data/repositories/auth_repository/di.dart';
import 'package:app_chat_proxy/data/source_storage/network/chat_api/chat_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/http_error.dart';
import '../../../../core/network/sender.dart';
import 'chat_http_api_config.dart';

final chatApiProvider = Provider<ChatApi>((ref) {
  return ChatApiImp(
    sender: Sender(
      httpApiConfig: ChatHttpConfig(
        authRepository: ref.read(authRepositoryProvider),
      ),
      errorProcessing: ref.read(errorProcessingProvider),
    ),
  );
});
