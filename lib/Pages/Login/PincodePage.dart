import 'package:flutter/material.dart';
import 'package:rainbow_app/Backend/APIS/LoginService.dart';
import 'package:rainbow_app/Backend/Models/LoginModel.dart';
import 'package:rainbow_app/Pages/Login/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Backend/APIS/UserEmployeeService.dart';
import '../../Backend/Models/UserModel.dart';
import '../../Components/Tiles/UserProfileTile.dart';
import '../../Theme/ThemeColor.dart';
import '../../Theme/ThemeTextStyle.dart';
import '../../main.dart';

class PincodePage extends StatefulWidget {
  static const String routeName = '/pincode';
  const PincodePage({Key? key}) : super(key: key);

  @override
  State<PincodePage> createState() => _PincodePageState();
}

class _PincodePageState extends State<PincodePage> {
  int? i = 1;
  bool isApiCallProcess = false;
  bool loginSuccessfull = false;
  String message = "";

  @override
  void initState() {
    _loadUrlUsernameAndPassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: RainbowColor.secondary,
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 35,
                ),
                Image.asset('assets/images/rainbow.png'),
                const SizedBox(
                  height: 10,
                ),
                UserProfileTile(
                  loginSuccessfull: loginSuccessfull,
                  message: message,
                )
              ]),
        ));
  }

  //load email and password
  void _loadUrlUsernameAndPassword() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var _url = preferences.getString("url") ?? "";
      var _username = preferences.getString("username") ?? "";
      var _password = preferences.getString("password") ?? "";
      var _langCode = preferences.getString("language") ?? "English";
      var _theme = preferences.getInt("theme");

      LoginService loginService = LoginService();
      LoginRequestModel loginRequestModel = LoginRequestModel(
          url: _url, username: _username, password: _password);
      loginService.login(loginRequestModel).then((value) {
        if (value.valid == true) {
          setState(() {
            LoggedInUser.loggedInUser = UserModel(
                emId: value.emId,
                emCode: value.emCode,
                username: value.username,
                firstName: value.firstName,
                lastName: value.lastName,
                roles: value.roles,
                departmentCode: value.departmentCode,
                departmentDescription: value.departmentDescription,
                jobCode: value.jobCode,
                jobDescription: value.jobDescription,
                leaveBalance: value.leaveBalance,
                selectedRoleId: value.selectedRoleId,
                token: value.token);
            LoggedInUser(
              true,
              UserModel(
                  emId: value.emId,
                  emCode: value.emCode,
                  username: value.username,
                  firstName: value.firstName,
                  lastName: value.lastName,
                  roles: value.roles,
                  departmentCode: value.departmentCode,
                  departmentDescription: value.departmentDescription,
                  jobCode: value.jobCode,
                  jobDescription: value.jobDescription,
                  leaveBalance: value.leaveBalance,
                  selectedRoleId: value.selectedRoleId,
                  token: value.token),
            );
            // LoggedInUser.role = UserRoleModel(value.roles);
            LoggedInUser.setToken(value.token);
            isApiCallProcess = false;
            loginSuccessfull = true;
          });
        } else {
          setState(() {
            isApiCallProcess = false;
            loginSuccessfull = false;
            message = value.response;
          });
        }
      });

      i = _theme;

      if (_langCode == "Nederlands") {
        MyApp.of(context)
            ?.setLocale(const Locale.fromSubtags(languageCode: 'nl'));
      } else if (_langCode == "English") {
        MyApp.of(context)
            ?.setLocale(const Locale.fromSubtags(languageCode: 'en'));
      }

      if (i == 1) {
        // setState(() {
        RainbowColor.primary_1 = Colors.blueAccent;
        RainbowColor.variant = Colors.blue;
        RainbowColor.primary_2 = Colors.blueAccent;
        // });
      } else if (i == 2) {
        // setState(() {
        RainbowColor.primary_1 = Colors.green;
        RainbowColor.variant = Colors.greenAccent;
        RainbowColor.primary_2 = Colors.lightGreen;
        // });
      } else if (i == 3) {
        // setState(() {
        RainbowColor.primary_1 = Colors.black;
        RainbowColor.variant = Colors.grey;
        RainbowColor.primary_2 = Colors.black;
        // });
      } else if (i == 4) {
        // setState(() {
        RainbowColor.primary_1 = Colors.purpleAccent;
        RainbowColor.variant = Colors.purple;
        RainbowColor.primary_2 = Colors.deepPurple;
        // });
      } else {
        // setState(() {
        RainbowColor.primary_1 = Colors.blueAccent;
        RainbowColor.variant = Colors.blue;
        RainbowColor.primary_2 = Colors.blueAccent;
        // });
      }
    } catch (e) {
      print(e);
    }
  }
}
