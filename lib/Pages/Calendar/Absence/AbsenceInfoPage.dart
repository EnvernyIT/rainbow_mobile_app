import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:rainbow_app/Components/OnlyReadFields/RButtonTextField.dart';
import 'package:rainbow_app/Components/OnlyReadFields/RField.dart';
import 'package:rainbow_app/Pages/Calendar/AbsenceListPage/AbsenceListPage.dart';
import 'package:rainbow_app/Pages/Dashboard/DashboardPage.dart';

import '../../../Backend/Models/Absence.dart';
import '../../../Backend/Models/Status.dart';
import '../../../Components/OnlyReadFields/RBigTextField.dart';
import '../../../Components/OnlyReadFields/RTitle.dart';
import '../../../Components/OnlyReadFields/RTextField.dart';
import '../../../Theme/ThemeColor.dart';
import '../../../Theme/ThemeTextStyle.dart';

class AbsenceInfoPage extends StatefulWidget {
  final Absence absence;

  const AbsenceInfoPage({Key? key, required this.absence}) : super(key: key);
  static const String routeName = '/absenceInfo';

  @override
  State<AbsenceInfoPage> createState() => _AbsenceInfoPageState();
}

class _AbsenceInfoPageState extends State<AbsenceInfoPage> {
  late String locale = Localizations.localeOf(context).languageCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 2,
        foregroundColor: RainbowColor.primary_1,
        bottomOpacity: 0,
        title: Text(AppLocalizations.of(context)!.absence,
            style: TextStyle(fontFamily: RainbowTextStyle.fontFamily)),
        backgroundColor: RainbowColor.secondary,
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        }),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3.0),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          children: [
            RField(
              title: AppLocalizations.of(context)!.leaveType,
              content: widget.absence.hourType?.usOmschrijving ?? "",
            ),
            RField(
                title: widget.absence.uaEindDat != widget.absence.usStartDate
                    ? AppLocalizations.of(context)!.duration
                    : AppLocalizations.of(context)!.day,
                content: (widget.absence.uaEindDat != widget.absence.usStartDate
                    ? showMDDate(widget.absence.usStartDate) +
                        " - " +
                        showMDDate(widget.absence.uaEindDat!)
                    : showYMDDate(widget.absence.usStartDate))),
            RField(
              title: AppLocalizations.of(context)!.total,
              content: widget.absence.numberOfLeaveDays.toString() +
                      " " +
                      AppLocalizations.of(context)!.dayss ??
                  " - " + AppLocalizations.of(context)!.dayss,
            ),
            RField(
              title: AppLocalizations.of(context)!.hours,
              content: widget.absence.uaAantalUren.toString() ?? "",
            ),
            RField(
              title: AppLocalizations.of(context)!.status,
              content: widget.absence.status!.ksOmschrijving ?? "",
              color: widget.absence.status?.statusNumber ==
                      Standardstatus.PR_70_APPROVED
                  ? Colors.green
                  : widget.absence.status?.statusNumber ==
                          Standardstatus.PR_70_REJECTED
                      ? Colors.redAccent
                      : Color.fromARGB(255, 193, 186, 186),
            ),
          ],
        ),
      ),
    );
  }

  String showMDDate(DateTime? date) {
    if (date != null) {
      String formatter = DateFormat.yMMMd().format(date);
      return formatter;
    }
    return " ";
  }

  String showYMDDate(DateTime? date) {
    if (date != null) {
      String formatter = DateFormat.yMMMEd().format(date);
      return formatter;
    }
    return " ";
  }
}
