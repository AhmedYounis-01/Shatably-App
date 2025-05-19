import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  final Locale locale;
  static late Map<String, dynamic> _localizedStrings;

  AppLocalizations(this.locale);

  static Future<AppLocalizations> load(Locale locale) async {
    final String jsonString =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    _localizedStrings = json.decode(jsonString);
    return AppLocalizations(locale);
  }

  String translate(String keyPath) {
    final keys = keyPath.split('.');
    dynamic value = _localizedStrings;
    for (var key in keys) {
      value = value[key];
      if (value == null) return keyPath; // Fallback if key not found
    }
    return value.toString();
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
