// // lib/common/localization/localization.dart
//
// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:intl/intl.dart';
// import 'package:intl/intl_standalone.dart';
//
// // This class will hold the app's localized strings.
// class AppLocalizations {
//   AppLocalizations(this.locale);
//
//   final Locale locale;
//
//   // Localized strings are accessed via static methods
//   static AppLocalizations? of(BuildContext context) {
//     return Localizations.of<AppLocalizations>(context, AppLocalizations);
//   }
//
//   static Future<AppLocalizations> load(Locale locale) {
//     return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
//   }
//
//   // Add your translations here
//   String get hello {
//     return Intl.message(
//       'Hello',
//       name: 'hello',
//       locale: locale.toString(),
//     );
//   }
//
//   String get welcome {
//     return Intl.message(
//       'Welcome',
//       name: 'welcome',
//       locale: locale.toString(),
//     );
//   }
//
// // Add more localized strings here
// }
//
// // This class is used to set up localization support in the app
// class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
//   const AppLocalizationsDelegate();
//
//   @override
//   bool isSupported(Locale locale) =>
//       ['en', 'es', 'fr'].contains(locale.languageCode);
//
//   @override
//   Future<AppLocalizations> load(Locale locale) {
//     return AppLocalizations.load(locale);
//   }
//
//   @override
//   bool shouldReload(AppLocalizationsDelegate old) => false;
// }
//
// // The list of localizations delegates
// final List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
//   const AppLocalizationsDelegate(),
//   GlobalMaterialLocalizations.delegate,
//   GlobalWidgetsLocalizations.delegate,
//   GlobalCupertinoLocalizations.delegate,
// ];
//
// // The list of supported locales
// final Iterable<Locale> supportedLocales = [
//   const Locale('en', ''), // English
//   const Locale('es', ''), // Spanish
//   const Locale('fr', ''), // French
// ];
//Purpose: Manages translations and localization for different languages.
// Usage: Used to manage and provide localized strings for multi-language support.
