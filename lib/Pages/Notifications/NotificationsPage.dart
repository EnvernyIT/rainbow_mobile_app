import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rainbow_app/Backend/Models/NotificationModel.dart';

import '../../Components/Navigation.dart';
import '../../Components/Tiles/NotificationTile.dart';
import '../../Theme/ThemeColor.dart';
import '../../Theme/ThemeTextStyle.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);
  static const String routeName = '/notifications';

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationModel> notifications = NotificationModel.notifications;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        foregroundColor: RainbowColor.primary_1,
        bottomOpacity: 0,
        title: Text(AppLocalizations.of(context)!.notifications,
            style: TextStyle(fontFamily: RainbowTextStyle.fontFamily)),
        backgroundColor: RainbowColor.secondary,
      ),
      body: RefreshIndicator(
          backgroundColor: RainbowColor.secondary,
          color: RainbowColor.primary_1,
          onRefresh: refresh,
          child: SingleChildScrollView(
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: notifications.length,
                itemBuilder: (BuildContext context, int index) {
                  return NotificationTile(
                    notification: notifications[index],
                  );
                }),
          )),
    );
  }

  Future refresh() async {
    setState(() {});
  }
}
