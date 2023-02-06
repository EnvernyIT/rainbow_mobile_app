import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class DateInputField extends StatelessWidget {
  final String startDate;
  final String endDate;
  final Function()? onTap;
  final Function()? onTap_1;

  const DateInputField({
    Key? key,
    this.onTap,
    this.onTap_1,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
          child: Container(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        height: 50,
        width: double.infinity,
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 25,
                color: Colors.grey[500],
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                startDate.isEmpty
                    ? AppLocalizations.of(context)!.startDate
                    : startDate,
                style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(4, 8),
            )
          ],
        ),
      )),
      Expanded(
          child: Container(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        height: 50,
        width: double.infinity,
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 25,
                color: Colors.grey[500],
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                endDate.isEmpty
                    ? AppLocalizations.of(context)!.endDate
                    : endDate,
                style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(4, 8),
            )
          ],
        ),
      )),
    ]);
  }
}
