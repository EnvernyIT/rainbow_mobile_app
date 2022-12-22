import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:rainbow_app/Backend/Models/Payslip.dart';
import 'package:rainbow_app/Pages/Payslips/PayslipPage/FileViewer.dart';
import 'package:rainbow_app/Theme/ThemeColor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Pages/Payslips/PayslipPage/PayslipViewPage.dart';
import '../../Theme/ThemeTextStyle.dart';

class PayslipTile extends StatefulWidget {
  final Payslip payslip;
  const PayslipTile({Key? key, required this.payslip}) : super(key: key);

  @override
  State<PayslipTile> createState() => _PayslipTileState();
}

class _PayslipTileState extends State<PayslipTile> {
  @override
  void initState() {
    super.initState();
  }

  bool? _isVisible = false;
  @override
  Widget build(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    return Container(
        decoration: const BoxDecoration(
          color: RainbowColor.secondary,
        ),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PayslipViewPage(payslip: widget.payslip)),
            );
          },
          leading: const Icon(
            Icons.payment,
            color: Colors.redAccent,
          ),
          title: Text(
            showDate(widget.payslip.peDatumVan, widget.payslip.hsPeriode),
            style: TextStyle(
              color: RainbowColor.primary_1,
              fontFamily: RainbowTextStyle.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
          trailing: InkWell(
            onTap: () {
              showAmount();
            },
            child: _isVisible != false
                ? Text(
                    widget.payslip.hsBedrag1.toString(),
                    style: TextStyle(
                      color: RainbowColor.hint,
                      fontFamily: RainbowTextStyle.fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  )
                : Text(
                    AppLocalizations.of(context)!.tapForSalary,
                    style: TextStyle(
                      color: RainbowColor.hint,
                      fontFamily: RainbowTextStyle.fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
          ),
        ));
  }

  void showAmount() {
    setState(() {
      _isVisible = !_isVisible!;
    });
  }

  String showDate(DateTime? date, int? periode) {
    String formatter = DateFormat.y().format(date!);
    return periode.toString() + " - " + formatter;
  }
}
