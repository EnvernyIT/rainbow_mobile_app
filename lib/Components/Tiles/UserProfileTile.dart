import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rainbow_app/Backend/Models/UserModel.dart';
import 'package:rainbow_app/Pages/Dashboard/DashboardPage.dart';
import 'package:rainbow_app/Pages/Login/LoginPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Theme/ThemeColor.dart';
import '../../Theme/ThemeTextStyle.dart';

class UserProfileTile extends StatelessWidget {
  UserProfileTile({Key? key}) : super(key: key);
  final pin = TextEditingController();

  @override
  void dispose() {
    pin.dispose();
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
                  backgroundImage:
                      const AssetImage('assets/images/blank-profile.png'),
                  backgroundColor: RainbowColor.primary_1,
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LoggedInUser.loggedInUser?.username ?? "",
                        style: TextStyle(
                            fontFamily: RainbowTextStyle.fontFamily,
                            fontSize: 18.0)),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                        (LoggedInUser.loggedInUser?.firstName ?? "") +
                            " " +
                            (LoggedInUser.loggedInUser?.lastName ?? ""),
                        style: TextStyle(
                            fontFamily: RainbowTextStyle.fontFamily,
                            fontSize: 14.0)),
                  ],
                )
              ])),
              IconButton(
                color: RainbowColor.primary_1,
                iconSize: 30,
                icon: const Icon(Icons.logout_outlined),
                onPressed: () {
                  GetStorage("data").remove("pin");
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
            // onSaved: (input) => String pincode = input,
            style: TextStyle(fontFamily: RainbowTextStyle.fontFamily),
            validator: (input) {
              if (input == null) {
                return AppLocalizations.of(context)!.givePincode;
              } else if (input.length < 4) {
                return AppLocalizations.of(context)!.fourOrMore;
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: GetStorage("data").read("pin") != null
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
                if (GetStorage("data").read("pin") != null) {
                  if (pin.text == GetStorage("data").read("pin")) {
                    SnackBar snackBar = SnackBar(
                      content: Text(AppLocalizations.of(context)!.correctPin),
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
                      content: Text(AppLocalizations.of(context)!.incorrectPin),
                      backgroundColor: Colors.redAccent,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                } else {
                  GetStorage("data").write("pin", pin.text);
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
              },
              icon: Icon(
                Icons.check_outlined,
                color: RainbowColor.primary_1,
              ),
              label: Text(
                GetStorage("data").read("pin") != null
                    ? AppLocalizations.of(context)!.verify
                    : AppLocalizations.of(context)!.create,
                style: TextStyle(
                    fontFamily: RainbowTextStyle.fontFamily,
                    color: RainbowColor.primary_1),
              ))
        ]));
  }
}
