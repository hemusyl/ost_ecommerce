
import 'package:flutter/material.dart';
import 'package:ost_ecommerce/l10n/app_localizations.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get localization {
    return AppLocalizations.of(this)!;
  }
}