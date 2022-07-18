import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:rainbow_app/Pages/Payslips/PayslipListPage/PayslipListPage.dart';
import 'package:rainbow_app/Pages/Payslips/PayslipPage/FileViewer.dart';

import '../../Backend/Models/Payslip.dart';
import '../../Theme/ThemeColor.dart';
import '../../Theme/ThemeTextStyle.dart';

class PayslipCard extends StatefulWidget {
  const PayslipCard({Key? key}) : super(key: key);

  @override
  State<PayslipCard> createState() => _PayslipCardState();
}

class _PayslipCardState extends State<PayslipCard> {
  List<Payslip> payslips = [];
  int i = 0;
  @override
  Widget build(BuildContext context) {
    Payslip payslip = Payslip.payslips[i];
    String locale = Localizations.localeOf(context).languageCode;
    return SingleChildScrollView(
      child: Container(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(
                    AppLocalizations.of(context)!.payslip,
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
                              builder: (context) => PayslipListPage()),
                        );
                      },
                      icon: const Icon(
                        Icons.library_books_outlined,
                        color: RainbowColor.secondary,
                        size: 30,
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 120,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(12),
                              backgroundColor: RainbowColor.primary_1,
                              shape: const StadiumBorder(),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FileViewer(
                                          payslip: payslip,
                                        )),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.read,
                              style: TextStyle(
                                  color: RainbowColor.secondary,
                                  fontFamily: RainbowTextStyle.fontFamily,
                                  fontSize: 15,
                                  height: 1,
                                  fontWeight: FontWeight.w600),
                            ))),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                        width: 120,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(12),
                              backgroundColor: RainbowColor.primary_1,
                              shape: const StadiumBorder(),
                            ),
                            onPressed: () {},
                            child: Text(
                              AppLocalizations.of(context)!.download,
                              style: TextStyle(
                                  color: RainbowColor.secondary,
                                  fontFamily: RainbowTextStyle.fontFamily,
                                  fontSize: 15,
                                  height: 1,
                                  fontWeight: FontWeight.w600),
                            )))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: RainbowColor.secondary,
                          boxShadow: [
                            BoxShadow(
                                color: RainbowColor.hint.withOpacity(0.6),
                                offset: const Offset(0, 10),
                                blurRadius: 20)
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        DateFormat.MMMM(locale).format(payslip.date) +
                            " " +
                            payslip.date.year.toString(),
                        style: TextStyle(
                            color: RainbowColor.primary_1,
                            fontFamily: RainbowTextStyle.fontFamily,
                            fontSize: 18,
                            height: 1,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              onTap: () {
                                goThroughList("neg");
                              },
                              child: Icon(
                                Icons.arrow_left_rounded,
                                size: 75,
                                color: RainbowColor.primary_1,
                              )),
                          InkWell(
                              onTap: () {
                                goThroughList("pos");
                              },
                              child: Icon(
                                Icons.arrow_right_rounded,
                                size: 75,
                                color: RainbowColor.primary_1,
                              )),
                        ])
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
              ])
            ],
          )),
    );
  }

  void goThroughList(String t) {
    setState(() {
      for (int x = 0; x < 7; x++) {
        payslips.add(Payslip.payslips[x]);
      }

      if (t == "neg") {
        // for (i = 0; i < 7; i++) {
        if (i == 6) {
          i = 0;
        } else {
          i++;
        }
        // }
      } else if (t == "pos") {
        // for (i = 0; i < 7; i++) {
        if (i == 0) {
          i = 6;
        } else {
          i--;
        }
        // }
      }
    });
  }
}
