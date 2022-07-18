import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Theme/ThemeColor.dart';
import '../../../Theme/ThemeTextStyle.dart';

class FontPage extends StatefulWidget {
  const FontPage({Key? key}) : super(key: key);

  @override
  State<FontPage> createState() => _FontPageState();
}

class _FontPageState extends State<FontPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        foregroundColor: RainbowColor.primary_1,
        bottomOpacity: 0,
        title: Text(AppLocalizations.of(context)!.font,
            style: TextStyle(fontFamily: RainbowTextStyle.fontFamily)),
        backgroundColor: RainbowColor.secondary,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              child: ListTile(
                onTap: () {
                  setState(() {
                    RainbowTextStyle.fontFamily = "Open Sans";
                    SharedPreferences.getInstance().then(
                      (prefs) {
                        prefs.setInt("theme", 0);
                      },
                    );
                  });
                },
                title: Text(
                  AppLocalizations.of(context)!.opensans,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: "Open Sans"),
                ),
              ),
            ),
            Container(
              child: ListTile(
                onTap: () {
                  setState(() {
                    RainbowTextStyle.fontFamily = "Raleway";
                    SharedPreferences.getInstance().then(
                      (prefs) {
                        prefs.setInt("theme", 1);
                      },
                    );
                  });
                },
                title: Text(
                  AppLocalizations.of(context)!.raleway,
                  style: const TextStyle(
                      color: Colors.black, fontSize: 18, fontFamily: "Raleway"),
                ),
              ),
            ),
            Container(
              child: ListTile(
                onTap: () {
                  setState(() {
                    RainbowTextStyle.fontFamily = "Montserrat";
                    SharedPreferences.getInstance().then(
                      (prefs) {
                        prefs.setInt("theme", 2);
                      },
                    );
                  });
                },
                title: Text(
                  AppLocalizations.of(context)!.montserrat,
                  style: const TextStyle(
                      color: Colors.black, fontSize: 18, fontFamily: "Hind"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
