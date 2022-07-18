import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Theme/ThemeColor.dart';
import '../../../Theme/ThemeTextStyle.dart';
import '../../Routes/Routes.dart';

class TypePage extends StatefulWidget {
  const TypePage({Key? key}) : super(key: key);

  @override
  State<TypePage> createState() => _StylePageState();
}

class _StylePageState extends State<TypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          foregroundColor: RainbowColor.primary_1,
          bottomOpacity: 0,
          title: Text(AppLocalizations.of(context)!.type,
              style: TextStyle(fontFamily: RainbowTextStyle.fontFamily)),
          backgroundColor: RainbowColor.secondary,
          leading: BackButton(onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.settings);
          }),
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Container(
                  alignment: Alignment.center,
                  child: ListTile(
                      onTap: () {
                        setState(() {
                          RainbowColor.primary_1 = Colors.blueAccent;
                          RainbowColor.variant = Colors.blue;
                          RainbowColor.primary_2 = Colors.blueAccent;
                          SharedPreferences.getInstance().then(
                            (prefs) {
                              prefs.setInt("theme", 1);
                            },
                          );
                        });
                      },
                      title: Text(
                        AppLocalizations.of(context)!.ocean,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: RainbowTextStyle.fontFamily),
                      ),
                      trailing: const CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.blueAccent,
                      ))),
              Container(
                  alignment: Alignment.center,
                  child: ListTile(
                      onTap: () {
                        setState(() {
                          RainbowColor.primary_1 = Colors.green;
                          RainbowColor.variant = Colors.greenAccent;
                          RainbowColor.primary_2 = Colors.lightGreen;
                          SharedPreferences.getInstance().then(
                            (prefs) {
                              prefs.setInt("theme", 2);
                            },
                          );
                        });
                      },
                      title: Text(
                        AppLocalizations.of(context)!.earth,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: RainbowTextStyle.fontFamily),
                      ),
                      trailing: const CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.green,
                      ))),
              Container(
                  alignment: Alignment.center,
                  child: ListTile(
                      onTap: () {
                        setState(() {
                          RainbowColor.primary_1 = Colors.black;
                          RainbowColor.variant = Colors.grey;
                          RainbowColor.primary_2 = Colors.black;
                          SharedPreferences.getInstance().then(
                            (prefs) {
                              prefs.setInt("theme", 3);
                            },
                          );
                        });
                      },
                      title: Text(
                        AppLocalizations.of(context)!.dark,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: RainbowTextStyle.fontFamily),
                      ),
                      trailing: const CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.black,
                      ))),
              Container(
                  alignment: Alignment.center,
                  child: ListTile(
                      onTap: () {
                        setState(() {
                          RainbowColor.primary_1 = Colors.purpleAccent;
                          RainbowColor.variant = Colors.purple;
                          RainbowColor.primary_2 = Colors.deepPurple;
                          SharedPreferences.getInstance().then(
                            (prefs) {
                              prefs.setInt("theme", 4);
                            },
                          );
                        });
                      },
                      title: Text(
                        AppLocalizations.of(context)!.orchid,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: RainbowTextStyle.fontFamily),
                      ),
                      trailing: const CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.purpleAccent,
                      ))),
            ],
          ),
        ));
  }
}
