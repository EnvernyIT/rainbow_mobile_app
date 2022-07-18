import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:rainbow_app/Theme/ThemeColor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Backend/Models/Absence.dart';
import '../../Theme/ThemeTextStyle.dart';

class AbsenceTile extends StatelessWidget {
  final Absence absence;
  const AbsenceTile({Key? key, required this.absence}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    return Container(
        padding: const EdgeInsets.all(15),
        color: absence.accepted == null
            ? Color.fromARGB(255, 193, 186, 186)
            : absence.accepted == true
                ? Colors.lightGreen
                : Colors.red,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            absence.days == true
                ? DateFormat.MMMEd(locale).format(absence.startDay!) +
                    " " +
                    AppLocalizations.of(context)!.tos +
                    " " +
                    DateFormat.yMMMEd(locale).format(absence.endDay!)
                : DateFormat.yMMMEd(locale).format(absence.startDay!) +
                    " (" +
                    absence.hours.toString() +
                    " hours)",
            style: TextStyle(
              color: RainbowColor.letter,
              fontFamily: RainbowTextStyle.fontFamily,
              fontSize: 17,
              height: 1,
            ),
          ),
          Text(
            absence.typeOfLeave!,
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
