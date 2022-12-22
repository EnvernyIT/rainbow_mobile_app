import 'package:rainbow_app/Pages/Calendar/AbsenceRequestPage/AbsenceRequestPage.dart';
import 'package:rainbow_app/Pages/Calendar/AbsenceListPage/AbsenceListPage.dart';
import 'package:rainbow_app/Pages/Calendar/CalendarPage/CalendarPage.dart';
import 'package:rainbow_app/Pages/Dashboard/DashboardPage.dart';
import 'package:rainbow_app/Pages/Login/LoginPage.dart';
import 'package:rainbow_app/Pages/Login/PincodePage.dart';
import 'package:rainbow_app/Pages/Notifications/NotificationsPage.dart';

import '../Calendar/Absence/AbsenceInfoPage.dart';
import '../Payslips/PayslipListPage/PayslipListPage.dart';
import '../Profile/ProfilePage.dart';
import '../Settings/SettingsPage.dart';
import '../SplashScreen/SplashScreenPage.dart';

class Routes {
  static const String login = LoginPage.routeName;
  static const String pincode = PincodePage.routeName;
  static const String dashboard = DashboardPage.routeName;
  // static const String calendar = CalendarPage.routeName;
  static const String payslips = PayslipListPage.routeName;
  static const String profile = ProfilePage.routeName;
  static const String settings = SettingsPage.routeName;
  static const String notifications = NotificationsPage.routeName;
  static const String absenceRequest = AbsenceRequestPage.routeName;
  static const String absenceList = AbsenceListPage.routeName;
  static const String splashScreen = SplashScreenPage.routeName;
  static const String absenceInfoPage = AbsenceInfoPage.routeName;
}
