import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_keys.dart';

final Provider<AppKeys> appKeysProvider = Provider((ref) {
  return AppChatProxyKeys(
    appKey: GlobalKey(),
    routeKey: GlobalKey(),
  );
});
