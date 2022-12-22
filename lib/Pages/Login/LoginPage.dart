import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rainbow_app/Backend/Models/UserModel.dart';
import 'package:rainbow_app/Theme/ThemeColor.dart';
import 'package:rainbow_app/Theme/ThemeTextStyle.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rainbow_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Backend/APIS/LoginService.dart';
import '../../Backend/Models/LoginModel.dart';
import '../../Components/ProgressHUD.dart';
import 'PincodePage.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool hidePassword = true;
  late LoginRequestModel requestModel;
  bool checkedValue = false;

  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isApiCallProcess = false;
  String languageValue = GetStorage("data").read("language") != null
      ? GetStorage("data").read("language").toString()
      : "English";
  var items = [
    'Nederlands',
    'English',
  ];
  String langCode = "English";
  String theme = "Open Sans";
  // int? i = 1;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: uiBuild(context), inAsyncCall: isApiCallProcess, opacity: 0.5);
  }

  @override
  void initState() {
    _loadUrlUsernameAndPassword();
    requestModel = LoginRequestModel();
    super.initState();
  }

  Widget uiBuild(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: RainbowColor.primary_1,
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
            child: Form(
              key: globalFormKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 25,
                  ),
                  Image.asset('assets/images/rainbow.png'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context)!.welcome,
                    style: TextStyle(
                        fontFamily: RainbowTextStyle.fontFamily,
                        color: RainbowColor.primary_1,
                        fontSize: 25,
                        height: 1,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _urlController,
                    keyboardType: TextInputType.url,
                    style: TextStyle(fontFamily: RainbowTextStyle.fontFamily),
                    onSaved: (input) => requestModel.url = input,
                    validator: (input) {
                      if (input == null) {
                        return AppLocalizations.of(context)!.giveLink;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.url,
                      hintStyle:
                          TextStyle(fontFamily: RainbowTextStyle.fontFamily),
                      errorStyle:
                          TextStyle(fontFamily: RainbowTextStyle.fontFamily),
                      labelStyle:
                          TextStyle(fontFamily: RainbowTextStyle.fontFamily),
                      helperStyle:
                          TextStyle(fontFamily: RainbowTextStyle.fontFamily),
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
                      prefixIcon: Icon(Icons.link, color: RainbowColor.variant),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontFamily: RainbowTextStyle.fontFamily),
                    onSaved: (input) => requestModel.username = input,
                    validator: (input) {
                      if (input == null) {
                        return AppLocalizations.of(context)!.giveUsername;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.username,
                      hintStyle:
                          TextStyle(fontFamily: RainbowTextStyle.fontFamily),
                      errorStyle:
                          TextStyle(fontFamily: RainbowTextStyle.fontFamily),
                      labelStyle:
                          TextStyle(fontFamily: RainbowTextStyle.fontFamily),
                      helperStyle:
                          TextStyle(fontFamily: RainbowTextStyle.fontFamily),
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
                      prefixIcon:
                          Icon(Icons.person, color: RainbowColor.variant),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontFamily: RainbowTextStyle.fontFamily),
                    onSaved: (input) => requestModel.password = input,
                    validator: (input) {
                      if (input == null || input.length < 3) {
                        return AppLocalizations.of(context)!.passwordCharacters;
                      }
                      return null;
                    },
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.password,
                      hintStyle:
                          TextStyle(fontFamily: RainbowTextStyle.fontFamily),
                      errorStyle:
                          TextStyle(fontFamily: RainbowTextStyle.fontFamily),
                      labelStyle:
                          TextStyle(fontFamily: RainbowTextStyle.fontFamily),
                      helperStyle:
                          TextStyle(fontFamily: RainbowTextStyle.fontFamily),
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
                      prefixIcon: Icon(
                        Icons.lock,
                        color: RainbowColor.variant,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        color: RainbowColor.variant!.withOpacity(0.4),
                        icon: Icon(hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  DropdownButton(
                    value: languageValue,
                    icon: const Padding(
                        //Icon at tail, arrow bottom is default icon
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(Icons.arrow_circle_down_sharp)),
                    iconEnabledColor: RainbowColor.primary_1, //Icon color
                    style: TextStyle(
                        color: RainbowColor.primary_1, //Font color
                        fontSize: 17, //font size on dropdown button
                        fontFamily: RainbowTextStyle.fontFamily),
                    dropdownColor:
                        RainbowColor.secondary, //dropdown background color
                    underline: Container(), //remove underline
                    isExpanded: false, //make true to make width 100%
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items,
                            style: TextStyle(
                                fontFamily: RainbowTextStyle.fontFamily)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        languageValue = newValue!;
                        if (languageValue == "Nederlands") {
                          MyApp.of(context)?.setLocale(
                              const Locale.fromSubtags(languageCode: 'nl'));
                        }
                        if (languageValue == "English") {
                          MyApp.of(context)?.setLocale(
                              const Locale.fromSubtags(languageCode: 'en'));
                        }
                        langCode = newValue;
                        SharedPreferences.getInstance().then(
                          (prefs) {
                            prefs.setString('language', newValue);
                          },
                        );
                      });
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 80,
                      ),
                      backgroundColor: RainbowColor.primary_1,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: (() {
                      if (validateAndSave()) {
                        setState(() {
                          isApiCallProcess = true;
                        });
                        //Login function when impementation is set
                        loginFunction();
                      }
                    }),
                    child: Text(
                      AppLocalizations.of(context)!.signIn,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: RainbowTextStyle.fontFamily),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  //handle remember me function
  void _handleRememberme(bool value) {
    checkedValue = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setString("url", _urlController.text);
        prefs.setString("username", _usernameController.text);
        prefs.setString("password", _passwordController.text);
        prefs.setString("language", langCode);
        prefs.setBool("loggedIn", true);
        prefs.setBool("remember_me", true);
      },
    );
    setState(() {
      checkedValue = value;
    });
  }

  //load email and password
  void _loadUrlUsernameAndPassword() async {
    var _url;
    var _username;
    var _password;
    var _rememberMe;
    var _langCode;
    var _theme;

    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      _url = preferences.getString("url") ?? "";
      _username = preferences.getString("username") ?? "";
      // _password = preferences.getString("password") ?? "";
      _rememberMe = preferences.getBool("remember_me") ?? true;
      _langCode = preferences.getString("language") ?? "English";
      _theme = preferences.getInt("theme");
    } catch (e) {
      print(e);
    }
    _urlController.text = _url;
    _usernameController.text = _username;
    // _passwordController.text = _password;
    langCode = _langCode;
    languageValue = _langCode;

    if (_langCode == "Nederlands") {
      MyApp.of(context)
          ?.setLocale(const Locale.fromSubtags(languageCode: 'nl'));
      languageValue = "Nederlands";
    } else if (_langCode == "English") {
      MyApp.of(context)
          ?.setLocale(const Locale.fromSubtags(languageCode: 'en'));
      languageValue = "English";
    }

    if (_theme == 1) {
      // setState(() {
      RainbowColor.primary_1 = Colors.blueAccent;
      RainbowColor.variant = Colors.blue;
      RainbowColor.primary_2 = Colors.blueAccent;
      // });
    } else if (_theme == 2) {
      // setState(() {
      RainbowColor.primary_1 = Colors.green;
      RainbowColor.variant = Colors.greenAccent;
      RainbowColor.primary_2 = Colors.lightGreen;
      // });
    } else if (_theme == 3) {
      // setState(() {
      RainbowColor.primary_1 = Colors.black;
      RainbowColor.variant = Colors.grey;
      RainbowColor.primary_2 = Colors.black;
      // });
    } else if (_theme == 4) {
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
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form != null) {
      if (form.validate()) {
        form.save();
        return true;
      }
    }
    return false;
  }

  void loginFunction() async {
    LoginService loginService = LoginService();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    loginService.login(requestModel).then((value) {
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
        LoggedInUser.setToken(value.token);
        setState(() {
          isApiCallProcess = false;
        });
        _handleRememberme(true);
        SnackBar snackBar = SnackBar(
          content: Text(AppLocalizations.of(context)!.loginSuccesful),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PincodePage()),
        );
      } else {
        setState(() {
          isApiCallProcess = false;
        });
        SnackBar snackBar = SnackBar(
          content: Text(AppLocalizations.of(context)!.credentialsDoNotMatch),
          backgroundColor: Colors.redAccent,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
}
