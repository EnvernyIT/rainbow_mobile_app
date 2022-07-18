import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:splashscreen/splashscreen.dart';

import '../../Backend/Models/UserModel.dart';
import '../../Theme/ThemeColor.dart';
import '../Login/LoginPage.dart';
import '../Login/PincodePage.dart';

class SplashScreenPage extends StatefulWidget {
  static const String routeName = '/splashScreen';
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 8,
      navigateAfterSeconds: LoggedInUser.loggedIn == true
          ? const LoginPage()
          : const PincodePage(),
      backgroundColor: RainbowColor.secondary,
      image: Image.asset('assets/images/rainbow.png'),
      photoSize: 150.0,
      title: const Text(
        "version - 1.0.0",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 21.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      loaderColor: RainbowColor.primary_1,
      useLoader: true,
    );
  }
}
