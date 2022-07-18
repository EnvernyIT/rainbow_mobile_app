import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Absence {
  final DateTime? startDay;
  final DateTime? endDay;
  final double? hours;
  final String? typeOfLeave;
  final String? description;
  final String? attest;
  final bool? days;
  final bool? accepted;

  Absence(
      {required this.startDay,
      this.endDay,
      this.hours,
      this.typeOfLeave,
      this.description,
      this.attest,
      required this.days,
      this.accepted});

  factory Absence.fromJson(Map<String, dynamic> json) {
    final startDay = json['startDay'] as DateTime;
    final endDay = json['endDay'] as DateTime;
    final hours = json['hours'] as double;
    final typeOfLeave = json['typeOfLeave'] as String;
    final description = json['description'] as String;
    final accepted = json['accepted'] as bool;
    final attest = json['attest'] as String;

    return Absence(
        startDay: startDay,
        endDay: endDay,
        hours: hours,
        days: false,
        typeOfLeave: typeOfLeave,
        description: description,
        accepted: accepted,
        attest: attest);
  }

  static List<Absence> absences = <Absence>[
    Absence(
        accepted: true,
        typeOfLeave: "Sick",
        startDay: DateTime.now().add(const Duration(days: 5)),
        days: false,
        hours: 4),
    Absence(
      accepted: false,
      typeOfLeave: "Personal",
      startDay: DateTime.now().add(const Duration(days: 18)),
      endDay: DateTime.now().add(const Duration(days: 23)),
      days: true,
    ),
    Absence(
        accepted: false,
        typeOfLeave: "Personal",
        startDay: DateTime.now().add(const Duration(days: 8)),
        days: false,
        hours: 4),
    Absence(
        accepted: null,
        typeOfLeave: "Sick",
        startDay: DateTime.now().add(const Duration(days: 11)),
        days: false,
        hours: 4),
    Absence(
        accepted: true,
        typeOfLeave: "Personal",
        startDay: DateTime.now().add(const Duration(days: 12)),
        days: false,
        hours: 4),
    Absence(
        accepted: null,
        typeOfLeave: "Sick",
        startDay: DateTime.now().add(const Duration(days: 13)),
        days: false,
        hours: 4),
    Absence(
      accepted: true,
      typeOfLeave: "Personal",
      startDay: DateTime.now().add(const Duration(days: 18)),
      endDay: DateTime.now().add(const Duration(days: 23)),
      days: true,
    ),
    Absence(
        accepted: true,
        typeOfLeave: "Personal",
        startDay: DateTime.now().add(const Duration(days: 12)),
        days: false,
        hours: 4),
    Absence(
        accepted: null,
        typeOfLeave: "Sick",
        startDay: DateTime.now().add(const Duration(days: 13)),
        days: false,
        hours: 4),
    Absence(
      accepted: true,
      typeOfLeave: "Personal",
      startDay: DateTime.now().add(const Duration(days: 18)),
      endDay: DateTime.now().add(const Duration(days: 23)),
      days: true,
    ),
    Absence(
        accepted: true,
        typeOfLeave: "Personal",
        startDay: DateTime.now().add(const Duration(days: 12)),
        days: false,
        hours: 4),
    Absence(
        accepted: null,
        typeOfLeave: "Sick",
        startDay: DateTime.now().add(const Duration(days: 13)),
        days: false,
        hours: 4),
    Absence(
      accepted: true,
      typeOfLeave: "Personal",
      startDay: DateTime.now().add(const Duration(days: 18)),
      endDay: DateTime.now().add(const Duration(days: 23)),
      days: true,
    ),
    Absence(
        accepted: true,
        typeOfLeave: "Personal",
        startDay: DateTime.now().add(const Duration(days: 12)),
        days: false,
        hours: 4),
    Absence(
        accepted: null,
        typeOfLeave: "Sick",
        startDay: DateTime.now().add(const Duration(days: 13)),
        days: false,
        hours: 4),
    Absence(
      accepted: true,
      typeOfLeave: "Personal",
      startDay: DateTime.now().add(const Duration(days: 18)),
      endDay: DateTime.now().add(const Duration(days: 23)),
      days: true,
    ),
  ];
}

class AbsenceRequest {
  String? url;
  String? username;
  String? password;

  AbsenceRequest({
    this.url,
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'url': url?.trim(),
      'username': username?.trim(),
      'password': password?.trim(),
    };
    return map;
  }
}

class AbsenceDataSource extends CalendarDataSource {
  AbsenceDataSource(List<Absence> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startDay;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endDay;
  }

  @override
  String getSubject(int index) {
    return appointments![index].typeOfLeave;
  }

  // @override
  // bool isAllDay(int index) {
  //   return appointments![index].isAllDay;
  // }
}
