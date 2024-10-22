import 'package:datawiseai/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:datawiseai/features/login/login_screen.dart';
import 'package:datawiseai/features/home/home_provider.dart';
import 'package:datawiseai/features/home/home_screen.dart';
import 'package:datawiseai/localization/app_localizations.dart';
import 'package:datawiseai/features/intro/intro_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:datawiseai/firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  // Firebase initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      Logger.debug('User is currently signed out!');
    } else {
      Logger.debug('User is signed in!');
    }
  });

  // Run the app
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
        title: 'Data Wise AI', //
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Montserrat', // Set Montserrat as the default font
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
          '/login': (context) => LoginScreen(), // Login/Register screen
          '/home': (context) => const HomeScreen(), // Home screen after login
        },
      ),
    );
  }
}
