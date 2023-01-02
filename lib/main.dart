import 'package:flutter/material.dart';
import 'package:rainbow_app/Backend/Models/UserModel.dart';
import 'package:rainbow_app/Pages/Calendar/AbsenceListPage/AbsenceListPage.dart';
import 'package:rainbow_app/Pages/Calendar/CalendarPage/CalendarPage.dart';
import 'package:rainbow_app/Pages/Dashboard/DashboardPage.dart';
import 'package:rainbow_app/Pages/Login/PincodePage.dart';
import 'package:rainbow_app/Pages/Notifications/NotificationsPage.dart';
import 'package:rainbow_app/Pages/Payslips/PayslipListPage/PayslipListPage.dart';
import 'package:rainbow_app/Pages/Profile/ProfilePage.dart';
import 'package:rainbow_app/Pages/Settings/SettingsPage.dart';
import 'package:rainbow_app/Pages/SplashScreen/SplashScreenPage.dart';
import 'package:rainbow_app/Theme/ThemeColor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Pages/Calendar/Absence/AbsenceInfoPage.dart';
import 'Pages/Login/LoginPage.dart';
import 'Pages/Payslips/PayslipPage/PayslipViewPage.dart';

bool loggedIn = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  loggedIn = (prefs.getBool("loggedIn")) ?? false;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Locale? _locale;

  void setLocale(Locale value) {
    Future.delayed(const Duration(milliseconds: 15), () {
      setState(() {
        _locale = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rainbow Mobile App',
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          // primarySwatch: Colors.blue,
          ),
      initialRoute: '/splashScreen',
      routes: {
        '/login': (context) => const LoginPage(),
        '/pincode': (context) => const PincodePage(),
        '/dashboard': (context) => const DashboardPage(),
        // '/calendar': (context) => const CalendarPage(),
        '/payslips': (context) => PayslipListPage(),
        '/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/notifications': (context) => const NotificationsPage(),
        '/absenceList': (context) => const AbsenceListPage(),
        '/splashScreen': (context) => const SplashScreenPage(),
        // '/payslip': (context) => const PayslipViewPage(),
        // '/absenceInfo': (context) => const AbsenceInfoPage(),
      },
    );
  }
}
