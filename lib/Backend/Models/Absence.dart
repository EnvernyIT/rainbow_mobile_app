import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'Employee.dart';
import 'HourType.dart';
import 'Status.dart';

class Absence {
  int? uaId;
  HourType? hourType;
  Status? status;
  DateTime? usStartDate;
  DateTime? uaEindDat;
  int? uaAantalUren;
  String? uaOpmerking;
  String? indOverwrite;
  String? indOpboeking;
  Employee? employee;
  String? systemGenerated;
  int? numberOfLeaveDays;
  bool? lockedTimeKeeping;
  String? response;
  bool valid;

  Absence({
    this.uaId,
    this.hourType,
    this.status,
    this.usStartDate,
    this.uaEindDat,
    this.uaAantalUren,
    this.uaOpmerking,
    this.indOverwrite,
    this.indOpboeking,
    this.employee,
    this.systemGenerated,
    this.numberOfLeaveDays,
    this.lockedTimeKeeping,
    this.response,
    required this.valid,
  });

  List<Absence> getAbsenceList(List<dynamic> json) {
    List<Absence> absences = [];

    for (int i = 0; i <= json.length - 1; i++) {
      Absence absence = Absence(valid: true);
      absence.uaId = json[i]['uaId'] as int;

      //Hourtype
      HourType hourType = HourType(
        usId: json[i]['hourType']['usId'] as int,
        usCode: json[i]['hourType']['usCode'] as String,
        usOmschrijving: json[i]['hourType']['usOmschrijving'] as String,
        uuType: json[i]['hourType']['uuType'] as String,
        balance: json[i]['hourType']['balance'] as String,
        caption: json[i]['hourType']['caption'] as String,
        indActive: json[i]['hourType']['indActive'] as String,
        usAccorderen: json[i]['hourType']['usAccorderen'] as String,
        usCategorie: json[i]['hourType']['usCategorie'] as String,
        usInduren: json[i]['hourType']['usInduren'] as String,
        proces: Proces(
          caption: json[i]['hourType']['proces']['caption'] as String,
          kpId: json[i]['hourType']['proces']['kpId'] as int,
          kpOmschrijving:
              json[i]['hourType']['proces']['kpOmschrijving'] as String,
          kpSchedule: json[i]['hourType']['proces']['kpSchedule'] as String,
          kpSendReminder:
              json[i]['hourType']['proces']['kpSendReminder'] as String,
          kpType: json[i]['hourType']['proces']['kpType'] as String,
        ),
      );
      absence.hourType = hourType;

      //Status
      Status status = Status(
        statusNumber: json[i]['status']['statusNumber'] as int,
        ksOmschrijving: json[i]['status']['ksOmschrijving'] as String,
        caption: json[i]['status']['caption'] as String,
        proces: Proces(
          caption: json[i]['status']['proces']['caption'] as String,
          kpId: json[i]['status']['proces']['kpId'] as int,
          kpOmschrijving:
              json[i]['status']['proces']['kpOmschrijving'] as String,
          kpSchedule: json[i]['status']['proces']['kpSchedule'] as String,
          kpSendReminder:
              json[i]['status']['proces']['kpSendReminder'] as String,
          kpType: json[i]['status']['proces']['kpType'] as String,
        ),
      );
      absence.status = status;
      absence.usStartDate =
          DateTime.fromMillisecondsSinceEpoch(json[i]['usStartDate'] as int);
      absence.uaEindDat =
          DateTime.fromMillisecondsSinceEpoch(json[i]['uaEindDat'] as int);
      ;

      absence.uaAantalUren = json[i]['uaAantalUren'] as int;
      absence.uaOpmerking = json[i]['uaOpmerking'] as String;
      absence.indOverwrite = json[i]['indOverwrite'] as String;
      absence.indOpboeking = json[i]['indOpboeking'] as String;

      //Employee
      // absence.employee = json[i]['status'] as Employee;

      absence.systemGenerated = json[i]['systemGenerated'] as String;
      absence.numberOfLeaveDays = json[i]['numberOfLeavedays'] as int;
      absence.lockedTimeKeeping = json[i]['lockedTimeKeeping'] as bool;
      absence.response = "";
      absence.valid = true;
      absences.add(absence);
    }

    return absences;
  }

  // final uaId = json[0]['uaId'] as int;
  // final hourType = json[0]['hourType'] as HourType;
  // final status = json[0]['status'] as Status;
  // final usStartDate = json[0]['usStartDate'] as DateTime;
  // final uaEindDat = json[0]['uaEindDat'] as DateTime;
  // final uaAantalUren = json[0]['uaAantalUren'] as int;
  // final uaOpmerking = json[0]['uaOpmerking'] as String;
  // final indOverwrite = json[0]['indOverwrite'] as String;
  // final indOpboeking = json[0]['indOpboeking'] as String;
  // final employee = json[0]['employee'] as Employee;
  // final systemGenerated = json['systemGenerated'] as String;
  // final numberOfLeaveDays = json['numberOfLeaveDays'] as int;
  // final lockedTimeKeeping = json['lockedTimeKeeping'] as bool;
  factory Absence.fromJson(dynamic json) {
    // Absence absence = Absence();
    final uaId = json[0]['uaId'] as int;

    //Hourtype
    final hourType = HourType(
      usId: json[0]['hourType']['usId'] as int,
      usCode: json[0]['hourType']['usCode'] as String,
      usOmschrijving: json[0]['hourType']['usOmschrijving'] as String,
      uuType: json[0]['hourType']['uuType'] as String,
      balance: json[0]['hourType']['balance'] as String,
      caption: json[0]['hourType']['caption'] as String,
      indActive: json[0]['hourType']['indActive'] as String,
      usAccorderen: json[0]['hourType']['usAccorderen'] as String,
      usCategorie: json[0]['hourType']['usCategorie'] as String,
      usInduren: json[0]['hourType']['usInduren'] as String,
      proces: Proces(
        caption: json[0]['hourType']['proces']['caption'] as String,
        kpId: json[0]['hourType']['proces']['kpId'] as int,
        kpOmschrijving:
            json[0]['hourType']['proces']['kpOmschrijving'] as String,
        kpSchedule: json[0]['hourType']['proces']['kpSchedule'] as String,
        kpSendReminder:
            json[0]['hourType']['proces']['kpSendReminder'] as String,
        kpType: json[0]['hourType']['proces']['kpType'] as String,
      ),
    );

    //Status
    final status = Status(
      statusNumber: json[0]['status']['statusNumber'] as int,
      ksOmschrijving: json[0]['status']['ksOmschrijving'] as String,
      caption: json[0]['status']['caption'] as String,
      proces: Proces(
        caption: json[0]['status']['proces']['caption'] as String,
        kpId: json[0]['status']['proces']['kpId'] as int,
        kpOmschrijving: json[0]['status']['proces']['kpOmschrijving'] as String,
        kpSchedule: json[0]['status']['proces']['kpSchedule'] as String,
        kpSendReminder: json[0]['status']['proces']['kpSendReminder'] as String,
        kpType: json[0]['status']['proces']['kpType'] as String,
      ),
    );

    // absence.usStartDate =
    //     DateTime.parse((json[i]['usStartDate'] as int).toString());
    // absence.uaEindDat =
    //     DateTime.parse((json[i]['uaEindDat'] as int).toString());
    final usStartDate =
        DateTime.fromMillisecondsSinceEpoch(json[0]['usStartDate'] as int);
    final uaEindDat =
        DateTime.fromMillisecondsSinceEpoch(json[0]['uaEindDat'] as int);
    ;

    final uaAantalUren = json[0]['uaAantalUren'] as int;
    final uaOpmerking = json[0]['uaOpmerking'] as String;
    final indOverwrite = json[0]['indOverwrite'] as String;
    final indOpboeking = json[0]['indOpboeking'] as String;

    //Employee
    // absence.employee = json[i]['status'] as Employee;

    final systemGenerated = json[0]['systemGenerated'] as String;
    final numberOfLeaveDays = json[0]['numberOfLeavedays'] as int;
    final lockedTimeKeeping = json[0]['lockedTimeKeeping'] as bool;

    return Absence(
      uaId: uaId,
      hourType: hourType,
      status: status,
      usStartDate: usStartDate,
      uaEindDat: uaEindDat,
      uaAantalUren: uaAantalUren,
      uaOpmerking: uaOpmerking,
      indOverwrite: indOverwrite,
      indOpboeking: indOpboeking,
      // employee: employee,
      systemGenerated: systemGenerated,
      numberOfLeaveDays: numberOfLeaveDays,
      lockedTimeKeeping: lockedTimeKeeping, response: "", valid: true,
    );
  }
}

class AbsenceRequest {
  int? usId;
  String? dateFrom;
  String? dateTo;
  int? uaAantaluren;
  int? days;
  String? uaOpmerking;
  String? fileBytes;
  String? typeFile;

  AbsenceRequest({
    this.usId,
    this.dateFrom,
    this.dateTo,
    this.uaAantaluren,
    this.days,
    this.uaOpmerking,
    this.fileBytes,
    this.typeFile,
  });

  Map<String, dynamic> toAskJson() {
    Map<String, dynamic> map = {
      'usId': usId,
      'dateFrom': dateFrom,
      'dateTo': dateTo,
      'uaAantaluren': uaAantaluren,
      'days': days,
      'uaOpmerking': uaOpmerking,
      'fileBytes': fileBytes,
      'typeFile': typeFile,
    };
    return map;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'usId': usId,
      'dateFrom': dateFrom,
      'dateTo': dateTo,
      'uaAantaluren': uaAantaluren,
      'days': days,
      'uaOpmerking': uaOpmerking,
    };
    return map;
  }
}

// class AbsenceDataSource extends CalendarDataSource {
//   AbsenceDataSource(List<Absence> source) {
//     appointments = source;
//   }

//   @override
//   DateTime getStartTime(int index) {
//     return appointments![index].usStartDate;
//   }

//   @override
//   DateTime getEndTime(int index) {
//     return appointments![index].uaEindDat;
//   }

//   @override
//   String getSubject(int index) {
//     return appointments![index].hourType.caption;
//   }

//   // @override
//   // bool isAllDay(int index) {
//   //   return appointments![index].isAllDay;
//   // }
// }
