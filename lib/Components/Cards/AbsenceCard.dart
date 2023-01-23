import 'package:flutter/material.dart';
import 'package:rainbow_app/Backend/APIS/UserEmployeeService.dart';
import 'package:rainbow_app/Pages/Calendar/AbsenceRequestPage/AbsenceRequestPage.dart';
import 'package:rainbow_app/Pages/Calendar/AbsenceListPage/AbsenceListPage.dart';
import 'package:rainbow_app/Theme/ThemeColor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Backend/Models/UserModel.dart';
import '../../Theme/ThemeTextStyle.dart';

class AbsenceCard extends StatefulWidget {
  const AbsenceCard({Key? key}) : super(key: key);

  @override
  State<AbsenceCard> createState() => _AbsenceCardState();
}

class _AbsenceCardState extends State<AbsenceCard> {
  int leaveBalance = 0;

  @override
  void initState() {
    setLeaveBalance();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: RainbowColor.secondary,
        gradient: LinearGradient(
          colors: [
            // Colors.lightBlue[100]!,
            RainbowColor.primary_1,
            RainbowColor.secondary,
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        boxShadow: [
          BoxShadow(
              color: RainbowColor.hint.withOpacity(0.6),
              offset: const Offset(0, 10),
              blurRadius: 30)
        ],
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(),
            Text(
              AppLocalizations.of(context)!.absence,
              style: TextStyle(
                  color: RainbowColor.secondary,
                  fontFamily: RainbowTextStyle.fontFamily,
                  fontSize: 28,
                  height: 1,
                  fontWeight: FontWeight.w600),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AbsenceListPage()),
                  );
                },
                icon: const Icon(
                  Icons.library_books_outlined,
                  color: RainbowColor.secondary,
                  size: 30,
                )),
          ]),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.leaveBalance + ":",
                style: TextStyle(
                    color: RainbowColor.primary_1,
                    fontFamily: RainbowTextStyle.fontFamily,
                    fontSize: 16,
                    height: 1,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                leaveBalance.toString() +
                    " " +
                    AppLocalizations.of(context)!.hours,
                style: TextStyle(
                    color: Colors.green,
                    fontFamily: RainbowTextStyle.fontFamily,
                    fontSize: 19,
                    height: 1,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.saldoInDays + ":",
                  style: TextStyle(
                      color: RainbowColor.primary_1,
                      fontFamily: RainbowTextStyle.fontFamily,
                      fontSize: 16,
                      height: 1,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  inDays(leaveBalance) +
                      " " +
                      AppLocalizations.of(context)!.dayss,
                  style: TextStyle(
                      color: Colors.green,
                      fontFamily: RainbowTextStyle.fontFamily,
                      fontSize: 19,
                      height: 1,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(12),
                  backgroundColor: RainbowColor.primary_1,
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AbsenceRequestPage()),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.requestLeave,
                  style: TextStyle(
                      color: RainbowColor.secondary,
                      fontFamily: RainbowTextStyle.fontFamily,
                      fontSize: 15,
                      height: 1,
                      fontWeight: FontWeight.w600),
                ))
          ]),
        ],
      ),
    );
  }

  void setLeaveBalance() {
    UserEmployeeService userEmployeeService = UserEmployeeService();
    userEmployeeService.getLeaveBalance().then((value) {
      setState(() {
        leaveBalance = value;
      });
    });
  }

  String daysToHours(int days) {
    return (days * 8).toString();
  }

  String inDays(int leaveBalance) {
    if (leaveBalance > 0) {
      final days = (leaveBalance / 8);
      return days.toStringAsFixed(2).toString();
    }
    return "0";
  }
}
