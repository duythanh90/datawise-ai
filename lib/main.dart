import 'package:datawiseai/features/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'features/home/home_screen.dart';
import 'features/home/home_provider.dart';
import 'localization/app_localizations.dart';
import 'features/intro/intro_screen.dart';

void main() {
  runApp(const DataWiseAIApp());
}

class DataWiseAIApp extends StatelessWidget {
  const DataWiseAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: MaterialApp(
        supportedLocales: const [
          Locale('en', ''), // English
          Locale('es', ''), // Spanish
        ],
        title: 'Data Wise AI', // Updated title
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        initialRoute: '/intro',
        routes: {
          '/intro': (context) => const IntroScreen(), // Intro screen
          '/login': (context) => const LoginScreen(), // Login/Register screen
          '/home': (context) => const HomeScreen(), // Home screen after login
        },
      ),
    );
  }
}
