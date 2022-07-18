import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rainbow_app/Pages/Calendar/AbsenceRequestPage/AbsenceRequestPage.dart';
import 'package:rainbow_app/Pages/Calendar/AbsenceListPage/AbsenceListPage.dart';
import 'package:rainbow_app/Pages/Notifications/NotificationsPage.dart';
import 'package:rainbow_app/main.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../Backend/Models/Absence.dart';
import '../../../Backend/Models/NotificationModel.dart';
import '../../../Components/Navigation.dart';
import '../../../Theme/ThemeColor.dart';
import '../../../Theme/ThemeColor.dart';
import '../../../Theme/ThemeTextStyle.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  static const String routeName = '/calendar';

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late int notifications_length;

  @override
  void initState() {
    super.initState();
    notifications_length = getNotificationsLength();
  }

  Widget uiBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        foregroundColor: RainbowColor.primary_1,
        bottomOpacity: 0,
        title: Text(
          AppLocalizations.of(context)!.calendar,
          style: TextStyle(fontFamily: RainbowTextStyle.fontFamily),
        ),
        backgroundColor: RainbowColor.secondary,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AbsenceListPage()),
              );
            },
            icon: Icon(
              Icons.list_outlined,
              color: RainbowColor.primary_1,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationsPage()),
              );
              makeNotificationsRead();
            },
            icon: notifications_length > 0
                ? Stack(
                    children: <Widget>[
                      const Icon(
                        Icons.notifications_outlined,
                        size: 25,
                      ),
                      Positioned(
                        top: 0.0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            notifications_length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  )
                : Icon(
                    Icons.notifications_outlined,
                    color: RainbowColor.primary_1,
                  ),

            // icon: Icon(
            //   Icons.notifications_outlined,
            //   color: RainbowColor.primary_1,
            // ),
          )
        ],
      ),
      drawer: const Navigation(),
      body: SfCalendar(
        dataSource: _getDataSource(),
        appointmentTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 14,
            locale: Localizations.localeOf(context)),
        backgroundColor: RainbowColor.secondary,
        todayHighlightColor: RainbowColor.primary_1,
        cellBorderColor: RainbowColor.primary_1,
        view: CalendarView.month,
        monthViewSettings: MonthViewSettings(
          monthCellStyle: const MonthCellStyle(
            leadingDatesBackgroundColor: RainbowColor.hint,
          ),
          showTrailingAndLeadingDates: false,
          dayFormat: 'EEE',
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
          showAgenda: true,
          agendaViewHeight: 250,
          agendaItemHeight: 50,
          agendaStyle: AgendaStyle(
            backgroundColor: RainbowColor.secondary,
            appointmentTextStyle: TextStyle(
                // locale: Locale('en'),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: RainbowTextStyle.fontFamily),
            dateTextStyle: TextStyle(
                // locale: Locale('en'),
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: RainbowTextStyle.fontFamily),
            dayTextStyle: TextStyle(
                // locale: Locale('en'),
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: RainbowTextStyle.fontFamily),
          ),
        ),
        firstDayOfWeek: 1,
        showNavigationArrow: true,
        cellEndPadding: 5,
        showWeekNumber: true,
        weekNumberStyle: WeekNumberStyle(
            backgroundColor: RainbowColor.primary_1,
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                locale: Locale('en'),
                fontFamily: RainbowTextStyle.fontFamily)),
      ),
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
        child: Icon(Icons.add_outlined),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return uiBuild(context);
  }

  int getNotificationsLength() {
    int p = 0;
    for (int i = 0; i >= NotificationModel.notifications.length; i++) {
      if (!NotificationModel.notifications[i].read) {
        p++;
      }
    }
    return p;
  }

  void makeNotificationsRead() {
    for (int i = 0; i >= NotificationModel.notifications.length; i++) {
      NotificationModel.notifications[i].read = true;
    }
  }

  AbsenceDataSource _getDataSource() {
    final List<Absence> meetings = <Absence>[];

    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(days: 2));

    final DateTime startTime1 = today.add(const Duration(days: 13));
    final DateTime endTime1 = startTime1.add(const Duration(hours: 8));

    meetings.add(Absence(
        typeOfLeave: AppLocalizations.of(context)!.absence +
            " - " +
            AppLocalizations.of(context)!.training,
        startDay: startTime,
        endDay: endTime,
        days: true));

    meetings.add(
      Absence(
          typeOfLeave: AppLocalizations.of(context)!.absence +
              " - " +
              AppLocalizations.of(context)!.sick,
          startDay: startTime1,
          endDay: endTime1,
          days: false,
          hours: 4),
    );

    return AbsenceDataSource(meetings);
  }
}
