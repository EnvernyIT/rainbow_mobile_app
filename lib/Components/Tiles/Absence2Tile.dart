import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Backend/Models/Absence.dart';
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
      leading: widget.absence.accepted == null
          ? const Icon(
              Icons.access_time_outlined,
              color: Colors.grey,
            )
          : widget.absence.accepted != true
              ? const Icon(Icons.block, color: Colors.redAccent)
              : const Icon(Icons.check_circle_outline, color: Colors.green),
      subtitle: Text(
        widget.absence.days == true
            ? DateFormat.MMMEd(locale).format(widget.absence.startDay!) +
                " " +
                AppLocalizations.of(context)!.towith +
                " " +
                DateFormat.yMMMEd(locale).format(widget.absence.endDay!)
            : DateFormat.yMMMEd(locale).format(widget.absence.startDay!) +
                " (" +
                widget.absence.hours.toString() +
                " " +
                AppLocalizations.of(context)!.hours +
                ")",
        style: TextStyle(
          color: RainbowColor.letter,
          fontFamily: RainbowTextStyle.fontFamily,
          fontSize: 17,
          height: 1,
        ),
      ),
      title: Text(
        widget.absence.typeOfLeave == "Sick"
            ? AppLocalizations.of(context)!.sick
            : widget.absence.typeOfLeave == "Personal"
                ? AppLocalizations.of(context)!.personal
                : AppLocalizations.of(context)!.medical +
                    " " +
                    (widget.absence.days != true
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
