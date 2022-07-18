import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateInfo {
  final BuildContext context;
  final String locale;

  DateInfo({required this.context, required this.locale});
  List<String> getMonths() {
    var months = <String>[];

    for (int i = 0; i < 12; i++) {
      String x = DateFormat.MMMM(locale)
          .format(DateTime(DateTime.now().year, DateTime.now().month - i));
      months.add(x);
    }

    return months;
  }

  List<String> getYears() {
    var years = <String>[];
    var now = DateTime.now();
    for (int i = 0; i <= 10; i++) {
      String x = (now.year - i).toString();
      years.add(x);
    }

    return years;
  }
}
