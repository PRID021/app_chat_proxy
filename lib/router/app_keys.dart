import 'package:flutter/material.dart';

abstract class AppKeys {
  final GlobalKey appKey;
  final GlobalKey routeKey;
  AppKeys({required this.appKey, required this.routeKey});
  forceRebuild();
}

class AppChatProxyKeys extends AppKeys {
  AppChatProxyKeys({required super.appKey, required super.routeKey});
  @override
  forceRebuild() => (appKey.currentContext as Element).markNeedsBuild();
}
