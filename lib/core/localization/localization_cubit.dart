import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalizationCubit extends Cubit<Locale> {
  LocalizationCubit() : super(const Locale('en'));

  /// Load the saved language from SharedPreferences or default to 'ar'
  Future<void> loadLanguage() async {
    final languageCode = 'en';
    emit(Locale(languageCode));
  }
}
