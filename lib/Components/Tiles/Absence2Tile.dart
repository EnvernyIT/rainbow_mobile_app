import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rainbow_app/Backend/Models/Status.dart';

import '../../Backend/Models/Absence.dart';
import '../../Backend/Models/HourType.dart';
import '../../Pages/Calendar/Absence/AbsenceInfoPage.dart';
import '../../Theme/ThemeColor.dart';
import '../../Theme/ThemeTextStyle.dart';

class Absence2Tile extends StatefulWidget {
  final Absence absence;
  const Absence2Tile({Key? key, required this.absence}) : super(key: key);

  @override
  State<Absence2Tile> createState() => _Absence2TileState();
}

class _Absence2TileState extends State<Absence2Tile> {
  late String locale = Localizations.localeOf(context).languageCode;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {},
      leading: widget.absence.status?.statusNumber ==
              Standardstatus.PR_70_APPROVED
          ? const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            )
          : widget.absence.status?.statusNumber == Standardstatus.PR_70_REJECTED
              ? const Icon(Icons.block, color: Colors.redAccent)
              : const Icon(Icons.access_time_outlined,
                  color: Color.fromARGB(255, 193, 186, 186)),
      subtitle: Text(
        widget.absence.usStartDate == widget.absence.uaEindDat
            ? DateFormat.yMMMEd(locale).format(widget.absence.usStartDate!) +
                " (" +
                widget.absence.uaAantalUren.toString() +
                " " +
                AppLocalizations.of(context)!.hours +
                ")"
            : DateFormat.MMMEd(locale).format(widget.absence.usStartDate!) +
                " " +
                AppLocalizations.of(context)!.towith +
                " " +
                DateFormat.yMMMEd(locale).format(widget.absence.uaEindDat!),
        style: TextStyle(
          color: RainbowColor.letter,
          fontFamily: RainbowTextStyle.fontFamily,
          fontSize: 17,
          height: 1,
        ),
      ),
      title: Text(
        widget.absence.hourType?.usId == HourTypeId.SICK.value
            ? AppLocalizations.of(context)!.sick
            : widget.absence.hourType?.usId == HourTypeId.AWP.value
                ? "\"Absent Without Perm\""
                : AppLocalizations.of(context)!.medical +
                    " " +
                    (widget.absence.numberOfLeaveDays == 1
                        ? AppLocalizations.of(context)!.day
                        : AppLocalizations.of(context)!.days),
        style: TextStyle(
          color: RainbowColor.letter,
          fontFamily: RainbowTextStyle.fontFamily,
          fontSize: 20,
          height: 1,
        ),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AbsenceInfoPage(
                  absence: widget.absence,
                )),
      ),
    );
  }
}
