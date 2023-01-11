import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rainbow_app/Pages/Payslips/PayslipListPage/PayslipListPage.dart';
import 'package:rainbow_app/Pages/Payslips/PayslipPage/FileViewer.dart';
import 'package:rainbow_app/Pages/Payslips/PayslipPage/PayslipViewPage.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../Backend/APIS/PayslipService.dart';
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
  late PayslipRequestModel payslipRequestModel;
  Payslip payslip = Payslip();
  bool _isLoading = false;
  DateTime? month = DateTime.now();
  int yearNow = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    setList(2021);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Payslip payslip = payslips[i];
    String locale = Localizations.localeOf(context).languageCode;
    return SingleChildScrollView(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: RainbowColor.secondary,
            gradient: LinearGradient(
              colors: [
                // Colors.lightBlue[100]!,
                RainbowColor.primary_2,
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
                                    builder: (context) => PayslipViewPage(
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
                            onPressed: () async {
                              final filepath = getFilePath(
                                  payslip.hsPeriode.toString(),
                                  payslip.hsJaar.toString());
                              PayslipService service = PayslipService();
                              PayslipRequestModel payslipRequestModel =
                                  PayslipRequestModel(
                                      year: payslip.hsJaar,
                                      period: payslip.hsPeriode);
                              String bytes = await service
                                  .getPayslipFile(payslipRequestModel);
                              _createPdf(bytes, filepath);
                            },
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
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          showDate(month),
                          style: TextStyle(
                              color: RainbowColor.primary_1,
                              fontFamily: RainbowTextStyle.fontFamily,
                              fontSize: 18,
                              height: 1,
                              fontWeight: FontWeight.w700),
                        )),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              onTap: () {
                                goThroughList("neg");
                                print("i is now = " + i.toString());
                              },
                              child: Icon(
                                Icons.arrow_left_rounded,
                                size: 75,
                                color: RainbowColor.primary_1,
                              )),
                          InkWell(
                              onTap: () {
                                goThroughList("pos");
                                print("i is now = " + i.toString());
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
    if (t == "pos") {
      if (i == payslips.length - 1) {
        i = 0;
        setState(() {
          payslip = payslips.first;
          month = payslips.first.peDatumVan;
        });
      } else {
        i++;
        setState(() {
          payslip = payslips[i];
          month = payslips[i].peDatumVan;
        });
      }
    } else if (t == "neg") {
      if (i == 0) {
        i = payslips.length - 1;
        setState(() {
          payslip = payslips[i];
          month = payslips[i].peDatumVan;
        });
      } else {
        i--;
        setState(() {
          payslip = payslips[i];
          month = payslips[i].peDatumVan;
        });
      }
    }
  }

  void setList(int year) {
    PayslipService payslipService = PayslipService();
    payslipRequestModel = PayslipRequestModel(year: year);
    payslipService.getList(payslipRequestModel).then((value) {
      if (value != null) {
        setState(() {
          for (int i = 0; i <= 10; i++) {
            payslips.add(value[i]);
          }
          payslip = payslips.first;
          month = payslips.first.peDatumVan;
          _isLoading = true;
        });
      }
    });
  }

  String showDate(DateTime? date) {
    if (date != null) {
      String formatter = DateFormat.yMMMM().format(date);
      return formatter;
    }
    return " ";
  }

  String getFilePath(String periode, String jaar) {
    return 'Rainbow_Payslip_' + periode + '-' + jaar + '.pdf';
  }

  Future<void> _createPdf(String bytes, String fileName) async {
    try {
      PdfDocument document = PdfDocument.fromBase64String(bytes);
      final path = (await getApplicationDocumentsDirectory()).path;
      List<int> pdfByte = await document.save();
      File('$path/$fileName').writeAsBytes(pdfByte).then((value) => null);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FileViewer(
                  payslip: File('$path/$fileName'),
                  title: fileName,
                )),
      );
      document.dispose();
    } catch (e) {
      print(e);
    }
  }
}
