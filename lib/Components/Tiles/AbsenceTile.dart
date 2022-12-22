import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:rainbow_app/Theme/ThemeColor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Backend/Models/Absence.dart';
import '../../Backend/Models/Status.dart';
import '../../Theme/ThemeTextStyle.dart';

class AbsenceTile extends StatelessWidget {
  final Absence absence;
  const AbsenceTile({Key? key, required this.absence}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    return Container(
        padding: const EdgeInsets.all(15),
        color: absence.status?.statusNumber == Standardstatus.PR_70_APPROVED
            ? Colors.lightGreen
            : absence.status?.statusNumber == Standardstatus.PR_70_REJECTED
                ? Colors.red
                : Color.fromARGB(255, 193, 186, 186),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            absence.numberOfLeaveDays == 1
                ? DateFormat.yMMMEd(locale).format(absence.usStartDate!) +
                    " (" +
                    absence.uaAantalUren.toString() +
                    " " +
                    AppLocalizations.of(context)!.hours +
                    ")"
                : DateFormat.MMMEd(locale).format(absence.usStartDate!) +
                    " " +
                    AppLocalizations.of(context)!.towith +
                    " " +
                    DateFormat.yMMMEd(locale).format(absence.uaEindDat!),
            style: TextStyle(
              color: RainbowColor.letter,
              fontFamily: RainbowTextStyle.fontFamily,
              fontSize: 17,
              height: 1,
            ),
          ),
          Text(
            absence.hourType?.usOmschrijving ?? "",
            style: TextStyle(
              color: RainbowColor.letter,
              fontFamily: RainbowTextStyle.fontFamily,
              fontSize: 17,
              height: 1,
            ),
          )
        ]));
  }
}
