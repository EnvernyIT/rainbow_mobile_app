import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rainbow_app/Backend/Models/LoginModel.dart';
import 'package:rainbow_app/Backend/Models/UserModel.dart';
import 'package:rainbow_app/Pages/Dashboard/DashboardPage.dart';
import 'package:rainbow_app/Pages/Login/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Backend/APIS/LoginService.dart';
import '../../Backend/APIS/UserEmployeeService.dart';
import '../../Theme/ThemeColor.dart';
import '../../Theme/ThemeTextStyle.dart';

class UserProfileTile extends StatefulWidget {
  bool loginSuccessfull;
  String message;

  UserProfileTile({
    Key? key,
    required this.loginSuccessfull,
    required this.message,
  }) : super(key: key);

  @override
  State<UserProfileTile> createState() => _UserProfileTileState();
}

class _UserProfileTileState extends State<UserProfileTile> {
  final pin = TextEditingController();
  bool loginSuccessfull = false;
  String message = "";
  bool photoSet = false;
  String image = "";
  bool accessGranted = false;
  String errorMessage = "";
  String pincode = "";

  @override
  void dispose() {
    pin.dispose();
  }

  @override
  void initState() {
    setEmployeePhoto();
    checkAccess();
    setPincode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int times = 3;
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: RainbowColor.secondary,
          boxShadow: [
            BoxShadow(
                color: RainbowColor.hint.withOpacity(0.2),
                offset: const Offset(0, 10),
                blurRadius: 20)
          ],
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: Row(children: [
                CircleAvatar(
                    radius: 25.0,
                    backgroundColor: widget.loginSuccessfull
                        ? RainbowColor.primary_1
                        : Colors.red,
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
                const SizedBox(
                  width: 15.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        widget.loginSuccessfull
                            ? LoggedInUser.loggedInUser?.username ?? ""
                            : AppLocalizations.of(context)!.notLoggedIn,
                        style: TextStyle(
                            fontFamily: RainbowTextStyle.fontFamily,
                            fontSize: 18.0,
                            color: widget.loginSuccessfull
                                ? Colors.black
                                : Colors.red)),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                        widget.loginSuccessfull
                            ? (LoggedInUser.loggedInUser?.firstName ?? "") +
                                " " +
                                (LoggedInUser.loggedInUser?.lastName ?? "")
                            : AppLocalizations.of(context)!.pleaseGoToLogin,
                        style: TextStyle(
                            fontFamily: RainbowTextStyle.fontFamily,
                            fontSize: 14.0,
                            color: widget.loginSuccessfull
                                ? Colors.black
                                : Colors.red)),
                  ],
                )
              ])),
              IconButton(
                color: widget.loginSuccessfull
                    ? RainbowColor.primary_1
                    : Colors.red,
                iconSize: 30,
                icon: const Icon(Icons.logout_outlined),
                onPressed: () {
                  SharedPreferences.getInstance()
                      .then((prefs) => prefs.setString("pin", ""));
                  SharedPreferences.getInstance()
                      .then((prefs) => prefs.setBool("loggedIn", false));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: pin,
            keyboardType: TextInputType.number,
            style: TextStyle(fontFamily: RainbowTextStyle.fontFamily),
            validator: (input) {
              if (input == null || input.isEmpty) {
                return AppLocalizations.of(context)!.givePincode;
              } else if (input.length < 4) {
                return AppLocalizations.of(context)!.fourOrMore;
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: pincode.isNotEmpty
                  ? AppLocalizations.of(context)!.pincode
                  : AppLocalizations.of(context)!.giveNewPin,
              hintStyle: TextStyle(fontFamily: RainbowTextStyle.fontFamily),
              errorStyle: TextStyle(fontFamily: RainbowTextStyle.fontFamily),
              labelStyle: TextStyle(fontFamily: RainbowTextStyle.fontFamily),
              helperStyle: TextStyle(fontFamily: RainbowTextStyle.fontFamily),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: RainbowColor.primary_1.withOpacity(0.2),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: RainbowColor.primary_1,
                ),
              ),
              prefixIcon: Icon(Icons.person, color: RainbowColor.variant),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton.icon(
              onPressed: () {
                if (widget.loginSuccessfull) {
                  if (accessGranted) {
                    if (pincode.isNotEmpty) {
                      if (pin.text == pincode) {
                        SnackBar snackBar = SnackBar(
                          content:
                              Text(AppLocalizations.of(context)!.correctPin),
                          backgroundColor: Colors.green,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DashboardPage()),
                        );
                      } else {
                        SnackBar snackBar = SnackBar(
                          content:
                              Text(AppLocalizations.of(context)!.incorrectPin),
                          backgroundColor: Colors.redAccent,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } else {
                      SharedPreferences.getInstance()
                          .then((prefs) => prefs.setString("pin", pin.text));

                      SnackBar snackBar = SnackBar(
                        content: Text(AppLocalizations.of(context)!.pinSaved),
                        backgroundColor: Colors.green,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DashboardPage()),
                      );
                    }
                  } else {
                    SnackBar snackBar = SnackBar(
                      content: SizedBox(
                          height: 40,
                          child: Column(children: [
                            Text(
                              AppLocalizations.of(context)!.accessDenied,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              AppLocalizations.of(context)!.error +
                                  ": " +
                                  errorMessage,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                          ])),
                      backgroundColor: Colors.redAccent,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                } else {
                  SnackBar snackBar = SnackBar(
                    duration: const Duration(seconds: 10),
                    content: SizedBox(
                      height: 35,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                AppLocalizations.of(context)!.loginUnSuccessful,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Text(
                                widget.message.isNotEmpty
                                    ? AppLocalizations.of(context)!.reason +
                                        " " +
                                        widget.message
                                    : "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ))
                          ]),
                    ),
                    backgroundColor: Colors.redAccent,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              icon: Icon(
                Icons.check_outlined,
                color: RainbowColor.primary_1,
              ),
              label: Text(
                pincode.isNotEmpty
                    ? AppLocalizations.of(context)!.verify
                    : AppLocalizations.of(context)!.create,
                style: TextStyle(
                    fontFamily: RainbowTextStyle.fontFamily,
                    color: RainbowColor.primary_1),
              )),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.error_outline,
                    size: 20, color: RainbowColor.primary_1),
                const SizedBox(width: 13),
                Flexible(
                  child: Text(
                    AppLocalizations.of(context)!.pincodeExplanation,
                    style: TextStyle(
                        color: RainbowColor.primary_1, fontSize: 14),
                  ),
                ),
              ],
            ),
          )
        ]));
  }

  void setPincode() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        pincode = prefs.getString("pin") ?? "";
      });
    });
  }

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
          setState(() {
            loginSuccessfull = true;
          });
        } else {
          setState(() {
            loginSuccessfull = false;
            message = value.response;
          });
        }
      });
    } catch (e) {
      print(e);
    }
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

  Future<void> checkAccess() async {
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
        print(value);
        if (value.valid) {
          accessGranted = true;
        } else {
          errorMessage = value.response;
          accessGranted = false;
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
