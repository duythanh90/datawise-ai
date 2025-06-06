import 'package:datawiseai/features/home/notifications/notifications_provider.dart';
import 'package:datawiseai/features/intro/intro_screen_provider.dart';
import 'package:datawiseai/features/register/register_provider.dart';
import 'package:datawiseai/utils/app_constants.dart';
import 'package:datawiseai/utils/logger.dart';
import 'package:datawiseai/utils/storage_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:datawiseai/features/home/home_provider.dart';
import 'package:datawiseai/features/login/login_provider.dart';
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
  // ignore: library_private_types_in_public_api
  _DataWiseAIAppState createState() => _DataWiseAIAppState();
}

class _DataWiseAIAppState extends State<DataWiseAIApp> {
  final Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => IntroScreenProvider()),
        ChangeNotifierProvider(create: (_) => NotificationsProvider()),
      ],
      child: MaterialApp(
        locale: _locale,
        supportedLocales: AppConstants.supportedLocales,
        title: 'Data Wise AI',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Montserrat',
        ),
        routes: {
          '/home': (context) => const HomeScreen(),
        },
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
        home: FutureBuilder<String?>(
          future: StorageUtils.getUserToken(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            final hasToken = snapshot.data != null && snapshot.data!.isNotEmpty;
            return hasToken ? const HomeScreen() : const IntroScreen();
          },
        ),
      ),
    );
  }
}
