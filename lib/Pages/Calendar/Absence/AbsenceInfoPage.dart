import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:rainbow_app/Components/OnlyReadFields/RButtonTextField.dart';
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
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RTitle(
              title: AppLocalizations.of(context)!.absence +
                  ": " +
                  (widget.absence.hourType?.usOmschrijving ?? ""),
              subTitle: (widget.absence.uaEindDat != widget.absence.usStartDate
                      ? showMDDate(widget.absence.usStartDate)
                      : showYMDDate(widget.absence.usStartDate) +
                          " (" +
                          widget.absence.uaAantalUren.toString() +
                          " " +
                          AppLocalizations.of(context)!.hours +
                          ")") +
                  " " +
                  (widget.absence.uaEindDat != widget.absence.usStartDate
                      ? AppLocalizations.of(context)!.towiths +
                          " " +
                          showYMDDate(widget.absence.uaEindDat!)
                      : ""),
            ),
            const SizedBox(
              height: 25,
            ),
            RTextField(
              title: AppLocalizations.of(context)!.status,
              data_1: widget.absence.status?.statusNumber ==
                      Standardstatus.PR_70_APPROVED
                  ? AppLocalizations.of(context)!.approved
                  : widget.absence.status?.statusNumber ==
                          Standardstatus.PR_70_REJECTED
                      ? AppLocalizations.of(context)!.declined
                      : AppLocalizations.of(context)!.waiting,
              color_1: widget.absence.status?.statusNumber ==
                      Standardstatus.PR_70_APPROVED
                  ? Colors.lightGreen
                  : widget.absence.status?.statusNumber ==
                          Standardstatus.PR_70_REJECTED
                      ? Colors.red
                      : Color.fromARGB(255, 193, 186, 186),
              fontSize: 17.0,
            ),
            RBigTextField(
              title: AppLocalizations.of(context)!.description,
              data: widget.absence.uaOpmerking,
              fontSize: 17.0,
            ),
            // RButtonTextField(
            //   title: AppLocalizations.of(context)!.fileOrPhoto,
            //   fontSize: 17.0,
            //   buttonTitle: AppLocalizations.of(context)!.download,
            //   buttonIcon: const Icon(
            //     Icons.download,
            //     color: RainbowColor.secondary,
            //     size: 16.0,
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  String showMDDate(DateTime? date) {
    if (date != null) {
      String formatter = DateFormat.MMMEd().format(date);
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
