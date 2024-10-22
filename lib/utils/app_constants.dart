import 'dart:ui';

class AppConstants {
  static const List<String> supportedLanguages = ['English', 'Spanish'];

  // create supportedLocales from supportedLanguages
  static List<Locale> get supportedLocales {
    return supportedLanguages
        .map((language) => Locale(language == 'English' ? 'en' : 'es'))
        .toList();
  }
}
