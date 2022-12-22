import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Theme/ThemeColor.dart';
import '../../../Theme/ThemeTextStyle.dart';
import '../../../main.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        foregroundColor: RainbowColor.primary_1,
        bottomOpacity: 0,
        title: Text(AppLocalizations.of(context)!.settings,
            style: TextStyle(fontFamily: RainbowTextStyle.fontFamily)),
        backgroundColor: RainbowColor.secondary,
      ),
      body: Container(
        margin: const EdgeInsets.all(12),
        child: ListView(
          children: [
            Container(
                alignment: Alignment.center,
                child: ListTile(
                  trailing: myLocale.languageCode == 'nl'
                      ? Icon(
                          Icons.check,
                          color: RainbowColor.primary_1,
                          size: 24.0,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      MyApp.of(context)?.setLocale(
                          const Locale.fromSubtags(languageCode: 'nl'));
                      SharedPreferences.getInstance().then(
                        (prefs) {
                          prefs.setString('language', "Nederlands");
                        },
                      );
                    });
                  },
                  title: Text(
                    "Nederlands",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        fontFamily: RainbowTextStyle.fontFamily),
                  ),
                )),
            Container(
                alignment: Alignment.center,
                child: ListTile(
                  trailing: myLocale.languageCode == 'en'
                      ? Icon(
                          Icons.check,
                          color: RainbowColor.primary_1,
                          size: 24.0,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      MyApp.of(context)?.setLocale(
                          const Locale.fromSubtags(languageCode: 'en'));
                      SharedPreferences.getInstance().then(
                        (prefs) {
                          prefs.setString('language', "English");
                        },
                      );
                    });
                  },
                  title: Text(
                    "English",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        fontFamily: RainbowTextStyle.fontFamily),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
