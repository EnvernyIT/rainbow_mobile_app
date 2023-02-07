import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:rainbow_app/Components/Tiles/Absence2Tile.dart';

import '../../../Backend/APIS/AbsenceService.dart';
import '../../../Backend/Models/Absence.dart';
import '../../../Components/Navigation.dart';
import '../../../Theme/ThemeColor.dart';
import '../../../Theme/ThemeTextStyle.dart';
import '../AbsenceRequestPage/AbsenceRequestPage.dart';

class AbsenceListPage extends StatefulWidget {
  const AbsenceListPage({Key? key}) : super(key: key);
  static const String routeName = '/absenceList';

  @override
  State<AbsenceListPage> createState() => _AbsenceListPageState();
}

class _AbsenceListPageState extends State<AbsenceListPage> {
  List<Absence> absences = [];
  int listLength = 0;
  late String locale = Localizations.localeOf(context).languageCode;
  bool isCurrentRoutePincode = false;
  String message = "";
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
    setList();
    setleading();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
      drawer: const Navigation(),
      body: RefreshIndicator(
          backgroundColor: RainbowColor.secondary,
          color: RainbowColor.primary_1,
          onRefresh: () async {
            setState(() {
              isApiCallProcess = true;
            });
            await Future.delayed(const Duration(milliseconds: 500));
            refresh();
          },
          child: absences.isEmpty
              ? Column(children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                      child: Column(children: [
                    const Icon(
                      size: 100,
                      Icons.list_alt_outlined,
                      color: RainbowColor.hint,
                    ),
                    Text(
                      AppLocalizations.of(context)!.noAbsencesFound,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: RainbowTextStyle.fontFamily),
                    ),
                    Text(
                      message.isNotEmpty ? "(" + message + ")" : "",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 18,
                          fontFamily: RainbowTextStyle.fontFamily),
                    )
                  ])),
                  const SizedBox(
                    height: 6,
                  ),
                ])
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: listLength,
                  itemBuilder: (BuildContext context, int index) {
                    return Absence2Tile(absence: absences[index]);
                  })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AbsenceRequestPage()),
          );
        },
        foregroundColor: RainbowColor.secondary,
        backgroundColor: RainbowColor.primary_1,
        elevation: 2,
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  Future refresh() async {
    setState(() {
      isApiCallProcess = false;
    });
    absences.clear();
    setList();
  }

  void setList() {
    AbsenceService absenceService = AbsenceService();
    AbsenceRequest absenceRequest = AbsenceRequest();
    absenceService.getList(absenceRequest).then((value) {
      setState(() {
        if (value != null) {
          if (value.length == 1) {
            if (value.first.valid) {
              absences = value;
              listLength = absences.length;
              isApiCallProcess = false;
            } else {
              message = value.first.response!;
              isApiCallProcess = false;
            }
          } else {
            absences = value;
            listLength = absences.length;
            isApiCallProcess = false;
          }
        }
      });
    });
  }

  fromDateString(DateTime date) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String dateString = formatter.format(date);
    return dateString;
  }

  getDateDifferenceInDays(DateTime fromDate, DateTime toDate) {
    if (fromDate != toDate) {
      Duration diff = fromDate.difference(toDate);
      return diff.inDays;
    }
    return 1;
  }

  void setleading() {
    Navigator.popUntil(context, (route) {
      if (route.settings.name != '/pincode') {
        setState(() {
          isCurrentRoutePincode = true;
        });
      }
      return true;
    });
  }
}
