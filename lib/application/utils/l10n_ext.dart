import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'app_context_key.dart';

extension AppLocalizationsExt on BuildContext {
  AppLocalizations get appLocalizations =>
      AppLocalizations.of(this) ??
      AppLocalizations.of(AppKeys.routeKey.currentContext!)!;
}
