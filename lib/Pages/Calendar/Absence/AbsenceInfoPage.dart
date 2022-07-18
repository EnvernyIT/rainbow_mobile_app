import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:rainbow_app/Components/OnlyReadFields/RButtonTextField.dart';

import '../../../Backend/Models/Absence.dart';
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
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RTitle(
              title: AppLocalizations.of(context)!.absence +
                  ": " +
                  (widget.absence.typeOfLeave!),
              subTitle: (widget.absence.endDay != null
                      ? DateFormat.MMMEd(locale)
                          .format(widget.absence.startDay!)
                      : DateFormat.yMMMEd(locale)
                              .format(widget.absence.startDay!) +
                          " (" +
                          widget.absence.hours.toString() +
                          " " +
                          AppLocalizations.of(context)!.hours +
                          ")") +
                  " " +
                  (widget.absence.endDay != null
                      ? AppLocalizations.of(context)!.towiths +
                          " " +
                          DateFormat.yMMMEd(locale)
                              .format(widget.absence.endDay!)
                      : ""),
            ),
            const SizedBox(
              height: 25,
            ),
            RTextField(
              title: AppLocalizations.of(context)!.approval,
              data_1: widget.absence.accepted == null
                  ? AppLocalizations.of(context)!.waiting
                  : !widget.absence.accepted!
                      ? AppLocalizations.of(context)!.declined
                      : AppLocalizations.of(context)!.approved,
              color_1: widget.absence.accepted == null
                  ? Colors.grey
                  : !widget.absence.accepted!
                      ? Colors.redAccent
                      : Colors.green,
              fontSize: 17.0,
            ),
            RBigTextField(
              title: AppLocalizations.of(context)!.description,
              data: widget.absence.description,
              fontSize: 17.0,
            ),
            RButtonTextField(
              title: AppLocalizations.of(context)!.fileOrPhoto,
              fontSize: 17.0,
              buttonTitle: AppLocalizations.of(context)!.download,
              buttonIcon: const Icon(
                Icons.download,
                color: RainbowColor.secondary,
                size: 16.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
