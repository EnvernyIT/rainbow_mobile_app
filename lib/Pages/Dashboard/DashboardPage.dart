import 'package:flutter/material.dart';
import 'package:rainbow_app/Backend/Models/NotificationModel.dart';
import 'package:rainbow_app/Components/Cards/AbsenceCard.dart';
import 'package:rainbow_app/Components/Navigation.dart';
import 'package:rainbow_app/Pages/Notifications/NotificationsPage.dart';
import 'package:rainbow_app/Pages/Profile/ProfilePage.dart';

import '../../Components/Cards/PayslipCard.dart';
import '../../Theme/ThemeColor.dart';
import '../../Theme/ThemeTextStyle.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = '/dashboard';
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late int notifications_length;

  @override
  void initState() {
    super.initState();
    notifications_length = NotificationModel.notifications.length;
    // notifications_length = getNotificationsLength();
  }

  static String title = "Dashboard";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        foregroundColor: RainbowColor.primary_1,
        bottomOpacity: 0,
        title: Text(
          title,
          style: TextStyle(fontFamily: RainbowTextStyle.fontFamily),
        ),
        backgroundColor: RainbowColor.secondary,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
            icon: Icon(
              Icons.person_outline,
              color: RainbowColor.primary_1,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationsPage()),
              );
              makeNotificationsRead();
            },
            icon: notifications_length > 0
                ? Stack(
                    children: <Widget>[
                      const Icon(
                        Icons.notifications_outlined,
                        size: 25,
                      ),
                      Positioned(
                        top: 0.0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            notifications_length.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontFamily: RainbowTextStyle.fontFamily),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  )
                : Icon(
                    Icons.notifications_outlined,
                    color: RainbowColor.primary_1,
                  ),
          )
        ],
      ),
      drawer: const Navigation(),
      body: Container(
        decoration: const BoxDecoration(
          color: RainbowColor.secondary,
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [AbsenceCard(), PayslipCard()],
        ),
      ),
    );
  }

  int getNotificationsLength() {
    int p = 0;
    for (int i = 0; i >= NotificationModel.notifications.length; i++) {
      if (!NotificationModel.notifications[i].read) {
        p++;
      }
    }
    return p;
  }

  void makeNotificationsRead() {
    for (int i = 0; i >= NotificationModel.notifications.length; i++) {
      NotificationModel.notifications[i].read = true;
    }
  }
}
