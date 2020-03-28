import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './pages/home_page.dart';
import './pages/history_page.dart';
import './pages/new_prophecy_page.dart';
import './pages/load_page.dart';

import './handlers/auth.dart';
import './handlers/firebase.dart';
import './handlers/user_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  Map giveLang;
  FirebaseUser user;
  Widget _homePage = LoadPage();

  @override
  void initState() {
    super.initState();
    authHandler.checkIfLogged().then(
      (_) {
        firebaseHandler.apiSetApp();
        firebaseHandler.getDefaultData(userData.userId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Roboto',
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          accentColor: Colors.lightBlue,
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('fr', 'FR'),
          const Locale('de', 'DE'),
          const Locale('es', 'ES'),
          const Locale('it', 'IT'),
          const Locale('ru', 'RU'),
          const Locale('pt', 'PT'),
          const Locale('pl', 'PL'),
          const Locale('ja', 'JA'),
          const Locale('el', 'EL'),
        ],
        home: _homePage,
        routes: {
          '/home': (BuildContext context) => HomePage(),
          '/history': (BuildContext context) => HistoryPage(),
          '/new': (BuildContext context) => NewProphecyPage(),
        },
      );
    }
  }
}
