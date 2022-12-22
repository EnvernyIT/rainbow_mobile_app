import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rainbow_app/Pages/Settings/AllSettings/ThemePage.dart';

import '../../Components/Navigation.dart';
import '../../Theme/ThemeColor.dart';
import '../../Theme/ThemeTextStyle.dart';
import '../Routes/Routes.dart';
import 'AllSettings/FontPage.dart';
import 'AllSettings/LanguagePage.dart';
import 'AllSettings/TypePage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const String routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        foregroundColor: RainbowColor.primary_1,
        bottomOpacity: 0,
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: TextStyle(fontFamily: RainbowTextStyle.fontFamily),
        ),
        backgroundColor: RainbowColor.secondary,
      ),
      drawer: const Navigation(),
      body: Container(
        margin: const EdgeInsets.all(12),
        child: ListView(
          children: [
            Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 15),
                height: 30,
                child: Text(
                  AppLocalizations.of(context)!.style,
                  style: TextStyle(
                      color: RainbowColor.primary_1,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      fontFamily: RainbowTextStyle.fontFamily),
                )),
            Container(
                alignment: Alignment.center,
                child: ListTile(
                  style: ListTileStyle.list,
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                    color: RainbowColor.hint,
                  ),
                  iconColor: RainbowColor.primary_1,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TypePage()),
                    );
                  },
                  title: Text(
                    AppLocalizations.of(context)!.type,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: RainbowTextStyle.fontFamily),
                  ),
                )),
            // Container(
            //     alignment: Alignment.center,
            //     child: ListTile(
            //       style: ListTileStyle.list,
            //       trailing: const Icon(
            //         Icons.arrow_forward_ios_outlined,
            //         size: 16,
            //         color: RainbowColor.hint,
            //       ),
            //       iconColor: RainbowColor.primary_1,
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => const ThemePage()),
            //         );
            //       },
            //       title: Text(
            //         AppLocalizations.of(context)!.theme,
            //         style: const TextStyle(
            //           color: Colors.black,
            //           fontSize: 16,
            //         ),
            //       ),
            //     )),
            // Container(
            //     height: 52,
            //     alignment: Alignment.center,
            //     child: ListTile(
            //       style: ListTileStyle.list,
            //       trailing: const Icon(
            //         Icons.arrow_forward_ios_outlined,
            //         size: 16,
            //         color: RainbowColor.hint,
            //       ),
            //       iconColor: RainbowColor.primary_1,
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => const FontPage()),
            //         );
            //       },
            //       title: Text(
            //         AppLocalizations.of(context)!.font,
            //         style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 16,
            //             fontFamily: RainbowTextStyle.fontFamily),
            //       ),
            //     )),
            // SizedBox(
            //   height: 10.0,
            // ),
            Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 15),
                height: 30,
                child: Text(
                  AppLocalizations.of(context)!.application,
                  style: TextStyle(
                      color: RainbowColor.primary_1,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      fontFamily: RainbowTextStyle.fontFamily),
                )),
            SizedBox(
              height: 10.0,
            ),
            Container(
                height: 52,
                alignment: Alignment.center,
                child: ListTile(
                  style: ListTileStyle.list,
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                    color: RainbowColor.hint,
                  ),
                  iconColor: RainbowColor.primary_1,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LanguagePage()),
                    );
                  },
                  title: Text(
                    AppLocalizations.of(context)!.language,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: RainbowTextStyle.fontFamily),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
