import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:rainbow_app/Components/Tiles/Absence2Tile.dart';

import '../../../Backend/Models/Absence.dart';
import '../../../Theme/ThemeColor.dart';
import '../../../Theme/ThemeTextStyle.dart';

class AbsenceListPage extends StatefulWidget {
  const AbsenceListPage({Key? key}) : super(key: key);
  static const String routeName = '/absenceList';

  @override
  State<AbsenceListPage> createState() => _AbsenceListPageState();
}

class _AbsenceListPageState extends State<AbsenceListPage> {
  late String locale = Localizations.localeOf(context).languageCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        foregroundColor: RainbowColor.primary_1,
        bottomOpacity: 0,
        title: Text(AppLocalizations.of(context)!.absenceList,
            style: TextStyle(fontFamily: RainbowTextStyle.fontFamily)),
        backgroundColor: RainbowColor.secondary,
      ),
      body: Container(
          color: RainbowColor.secondary,
          child: RefreshIndicator(
              backgroundColor: RainbowColor.secondary,
              color: RainbowColor.primary_1,
              onRefresh: refresh,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Absence.absences.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Absence2Tile(absence: Absence.absences[index]);
                  }))),
    );
  }

  Future refresh() async {
    setState(() {});
  }
}
