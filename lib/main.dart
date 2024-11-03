import 'package:datawiseai/features/register/register_provider.dart';
import 'package:datawiseai/features/register/regsiter_screen.dart';
import 'package:datawiseai/utils/app_constants.dart';
import 'package:datawiseai/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:datawiseai/features/login/login_screen.dart';
import 'package:datawiseai/features/home/home_provider.dart';
import 'package:datawiseai/features/login/login_provider.dart'; // Import the LoginProvider
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

class DataWiseAIApp extends StatefulWidget {
  const DataWiseAIApp({super.key});

  @override
  _DataWiseAIAppState createState() => _DataWiseAIAppState();
}

class _DataWiseAIAppState extends State<DataWiseAIApp> {
  Locale _locale = const Locale('en');

  // Function to change the locale
  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = Locale(locale.languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
      ],
      child: MaterialApp(
        locale: _locale, // This will be dynamically updated
        supportedLocales: AppConstants.supportedLocales,
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
          // If locale is supported, use it, else fallback to the first one in supportedLocales
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        initialRoute: '/intro',
        routes: {
          '/intro': (context) => const IntroScreen(),
          '/login': (context) => LoginScreen(
                onLanguageSelected: _changeLanguage,
              ),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
