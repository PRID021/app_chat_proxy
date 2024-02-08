import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/source_storage/local/di.dart';
import 'user_repository.dart';
import '../../../data/repositories/user_repository/user_repository_imp.dart';

final Provider<UserRepository> userReferenceRepositoryProvider =
    Provider((ref) {
  return UserRepositoryImp(
    userReferenceDataStorage: ref.watch(dataStorageProvider),
  );
});
