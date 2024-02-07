import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.dart';

final Provider<AppRouter> appRouterProvider = Provider((ref) {
  return AppRouter();
});
