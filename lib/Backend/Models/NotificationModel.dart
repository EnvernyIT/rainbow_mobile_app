import 'package:flutter/material.dart';

import 'Absence.dart';
import 'Payslip.dart';
import 'enums/NotificationType.dart';

class NotificationModel {
  final DateTime? received;
  final String? title;
  final String? subText;
  final NotificationType? type;
  final Payslip? payslip;
  final Absence? absence;
  late final bool read;

  NotificationModel({
    this.received,
    this.title,
    this.subText,
    this.type,
    this.absence,
    this.payslip,
    required this.read,
  });

  static List<NotificationModel> notifications = [
    NotificationModel(
        received: DateTime(2022, 7, 11, 9, 30),
        title: "Verlof",
        subText: "Uw aanvraag van verlof is geaccepteerd",
        type: NotificationType.acceptedAbsence,
        read: false),
    NotificationModel(
        received: DateTime(2022, 6, 11, 9, 30),
        title: "Verlof",
        subText: "Uw aanvraag van verlof is NIET geaccepteerd",
        type: NotificationType.notAcceptedAbsence,
        read: false),
    // NotificationModel(
    //     received: DateTime(2022, 6, 25, 9, 30),
    //     title: "Loon",
    //     subText: "Uw loon is overgemaakt, Bekijk uw loonslip",
    //     type: NotificationType.loonslip,
    //     payslip: Payslip.payslips[0],
    //     read: false),
    // NotificationModel(
    //     received: DateTime(2022, 5, 25, 9, 30),
    //     title: "Loon",
    //     subText: "Uw loon is overgemaakt, Bekijk uw loonslip",
    //     type: NotificationType.loonslip,
    //     payslip: Payslip.payslips[1],
    //     read: false),
    // NotificationModel(
    //     received: DateTime(2022, 5, 20, 9, 30),
    //     title: "Verlof",
    //     subText: "Uw aanvraag van verlof is geaccepteerd",
    //     type: NotificationType.acceptedAbsence,
    //     read: false),
    // NotificationModel(
    //     received: DateTime(2022, 5, 10, 9, 30),
    //     title: "Verlof",
    //     subText: "Uw aanvraag van verlof is NIET geaccepteerd",
    //     type: NotificationType.notAcceptedAbsence,
    //     read: false),
    // NotificationModel(
    //     received: DateTime(2022, 4, 25, 9, 30),
    //     title: "Loon",
    //     subText: "Uw loon is overgemaakt, Bekijk uw loonslip",
    //     type: NotificationType.loonslip,
    //     payslip: Payslip.payslips[2],
    //     read: false),
    NotificationModel(
        received: DateTime(2022, 7, 11, 9, 30),
        title: "Verlof",
        subText: "Uw aanvraag van verlof is geaccepteerd",
        type: NotificationType.acceptedAbsence,
        read: false),
    NotificationModel(
        received: DateTime(2022, 7, 11, 9, 30),
        title: "Verlof",
        subText: "Uw aanvraag van verlof is geaccepteerd",
        type: NotificationType.acceptedAbsence,
        read: false),
  ];
}
