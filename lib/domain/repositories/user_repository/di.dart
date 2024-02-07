import 'package:app_chat_proxy/domain/repositories/user_repository/user_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/local/di.dart';
import 'user_repository.dart';

final Provider<UserRepository> userReferenceRepositoryProvider =
    Provider((ref) {
  return UserRepositoryImp(
    userReferenceDataStorage: ref.watch(dataStorageProvider),
  );
});
