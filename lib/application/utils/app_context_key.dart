import 'package:flutter/material.dart';

abstract class AppKeys {
  static final GlobalKey appKey = GlobalKey();
  static final GlobalKey routeKey = GlobalKey();
  static forceRebuild() => (appKey.currentContext! as Element).markNeedsBuild();
}
