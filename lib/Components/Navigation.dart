import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rainbow_app/Theme/ThemeColor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Backend/APIS/UserEmployeeService.dart';
import '../Backend/Models/UserModel.dart';
import '../Pages/Routes/Routes.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  bool photoSet = false;
  String image = "";

  @override
  Widget build(BuildContext context) {
    return createDrawer(context);
  }

  @override
  void initState() {
    setEmployeePhoto();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget createDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: RainbowColor.secondary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createHeader(),
          createDrawerItem(
            icon: Icons.calendar_month_outlined,
            text: AppLocalizations.of(context)!.dashboard,
            onTap: () =>
                Navigator.pushReplacementNamed(context, Routes.dashboard),
          ),
          createDrawerItem(
            icon: Icons.calendar_today_outlined,
            text: AppLocalizations.of(context)!.absences,
            onTap: () =>
                Navigator.pushReplacementNamed(context, Routes.absenceList),
          ),
          createDrawerItem(
            icon: Icons.payment_outlined,
            text: AppLocalizations.of(context)!.payslips,
            onTap: () =>
                Navigator.pushReplacementNamed(context, Routes.payslips),
          ),
          createDrawerItem(
            icon: Icons.person_outlined,
            text: AppLocalizations.of(context)!.profile,
            onTap: () =>
                Navigator.pushReplacementNamed(context, Routes.profile),
          ),
          createDrawerItem(
            icon: Icons.settings_outlined,
            text: AppLocalizations.of(context)!.settings,
            onTap: () =>
                Navigator.pushReplacementNamed(context, Routes.settings),
          ),
          createDrawerItem(
            icon: Icons.logout_outlined,
            text: AppLocalizations.of(context)!.signOut,
            onTap: () =>
                Navigator.pushReplacementNamed(context, Routes.pincode),
          ),
          const SizedBox(
            height: 30,
          ),
          // ListTile(
          //   title: const Text(
          //     'created by BLU-DOTS',
          //     style: TextStyle(color: RainbowColor.primary_1, fontSize: 18),
          //   ),
          //   onTap: () {},
          // )
        ],
      ),
    );
  }

  Widget createHeader() {
    String username, name, lastName;
    if (LoggedInUser.loggedInUser?.firstName == null) {
      username = "User";
      name = "User - System";
      lastName = "";
    } else {
      username = LoggedInUser.loggedInUser?.username ?? "";
      name = LoggedInUser.loggedInUser?.firstName ?? "";
      lastName = LoggedInUser.loggedInUser?.lastName ?? "";
    }

    return UserAccountsDrawerHeader(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [RainbowColor.primary_1, RainbowColor.primary_2],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight),
        ),
        accountName: Text(
          username,
          style: const TextStyle(
              fontSize: 20,
              height: 2,
              color: RainbowColor.secondary,
              fontStyle: FontStyle.italic),
        ),
        accountEmail: Text(
          name + " " + lastName,
          style: const TextStyle(
              fontSize: 15,
              color: RainbowColor.secondary,
              fontStyle: FontStyle.italic),
        ),
        currentAccountPicture: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                  radius: 36.0,
                  backgroundColor: RainbowColor.primary_1,
                  child: SizedBox(
                      width: 80,
                      height: 80,
                      child: ClipOval(
                          child: image.isNotEmpty
                              ? Image.memory(
                                  base64Decode(image),
                                  fit: BoxFit.fill,
                                )
                              : Image.asset(
                                  'assets/images/blank-profile.png')))),
            ]));
  }

  Widget createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(children: <Widget>[
        Icon(
          icon,
          color: RainbowColor.primary_1,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(text,
              style: TextStyle(
                  color: RainbowColor.primary_1,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal)),
        )
      ]),
      onTap: onTap,
    );
  }

  void setEmployeePhoto() {
    UserEmployeeService service = UserEmployeeService();
    service.getEmployeeInfo().then((value) {
      setState(() {
        if (value.valid) {
          if (value.photo != null) {
            photoSet = true;
            if (value.photo?.phImage != null) {
              image = value.photo?.phImage ?? "";
            }
          }
        }
      });
    });
  }
}
