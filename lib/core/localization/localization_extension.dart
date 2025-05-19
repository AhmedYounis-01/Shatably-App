import 'package:flutter/material.dart';
import 'app_localization.dart';

extension LocalizationExtension on String {
  String t(BuildContext context) {
    return AppLocalizations.of(context).translate(this);
  }
}
