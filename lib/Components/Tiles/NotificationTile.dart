import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rainbow_app/Backend/Models/Absence.dart';
import 'package:rainbow_app/Backend/Models/Payslip.dart';
import 'package:rainbow_app/Backend/Models/enums/NotificationType.dart';
import 'package:rainbow_app/Pages/Calendar/AbsenceListPage/AbsenceListPage.dart';
import 'package:rainbow_app/Pages/Payslips/PayslipListPage/PayslipListPage.dart';
import 'package:rainbow_app/Pages/Payslips/PayslipPage/FileViewer.dart';

import '../../Backend/Models/NotificationModel.dart';
import '../../Theme/ThemeColor.dart';
import '../../Theme/ThemeTextStyle.dart';

class NotificationTile extends StatefulWidget {
  final NotificationModel notification;

  const NotificationTile({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      color: !widget.notification.read
          ? RainbowColor.primary_1.withOpacity(0.1)
          : RainbowColor.secondary,
      child: ListTile(
          onTap: () {
            if (widget.notification.type == NotificationType.loonslip) {
              if (widget.notification.payslip != null) {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => FileViewer(
                //             payslip: widget.notification.payslip!,
                //           )),
                // );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PayslipListPage()),
                );
              }
            } else if (widget.notification.type ==
                    NotificationType.acceptedAbsence ||
                widget.notification.type ==
                    NotificationType.notAcceptedAbsence) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AbsenceListPage()),
              );
            }
          },
          leading: widget.notification.type == NotificationType.loonslip
              ? Icon(
                  Icons.monetization_on,
                  color: RainbowColor.primary_1,
                )
              : widget.notification.type == NotificationType.acceptedAbsence ||
                      widget.notification.type ==
                          NotificationType.notAcceptedAbsence
                  ? Icon(Icons.calendar_month, color: RainbowColor.primary_1)
                  : null,
          subtitle: Text(
            widget.notification.subText!,
            style: TextStyle(
              color: RainbowColor.letter,
              fontFamily: RainbowTextStyle.fontFamily,
              fontSize: 14,
              height: 1,
            ),
          ),
          title: Text(
            widget.notification.title!,
            style: TextStyle(
              color: RainbowColor.primary_1,
              fontFamily: RainbowTextStyle.fontFamily,
              fontSize: 18,
              height: 1,
            ),
          ),
          trailing: widget.notification.type == NotificationType.loonslip
              ? const Icon(Icons.picture_as_pdf, color: Colors.redAccent)
              : widget.notification.type == NotificationType.acceptedAbsence
                  ? const Icon(Icons.check_circle_outline, color: Colors.green)
                  : widget.notification.type ==
                          NotificationType.notAcceptedAbsence
                      ? const Icon(Icons.block, color: Colors.redAccent)
                      : Container()),
    );
  }
}
