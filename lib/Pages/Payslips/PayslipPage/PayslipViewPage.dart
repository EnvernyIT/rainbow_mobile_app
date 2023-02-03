import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rainbow_app/Backend/APIS/PayslipService.dart';
import 'package:rainbow_app/Components/OnlyReadFields/RTextField.dart';
import 'package:rainbow_app/Pages/Payslips/PayslipPage/FileViewer.dart';
import 'package:rainbow_app/Theme/ThemeColor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

import '../../../Backend/Constants/ConstantUtil.dart';
import '../../../Backend/Models/Payslip.dart';
import '../../../Components/Navigation.dart';
import '../../../Components/ProgressHUD.dart';
import '../../../Theme/ThemeTextStyle.dart';

class PayslipViewPage extends StatefulWidget {
  final Payslip payslip;

  PayslipViewPage({Key? key, required this.payslip}) : super(key: key);

  @override
  State<PayslipViewPage> createState() => _PayslipViewPageState();
}

class _PayslipViewPageState extends State<PayslipViewPage> {
  String errorMessage = "";

  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: uiBuild(context), inAsyncCall: isApiCallProcess, opacity: 0.5);
  }

  Widget uiBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 2,
        foregroundColor: RainbowColor.primary_1,
        bottomOpacity: 0,
        title: Text(AppLocalizations.of(context)!.payslip,
            style: TextStyle(fontFamily: RainbowTextStyle.fontFamily)),
        backgroundColor: RainbowColor.secondary,
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {
                  isApiCallProcess = true;
                });
                final filepath = getFilePath(
                    widget.payslip.hsPeriode.toString(),
                    widget.payslip.hsJaar.toString());
                PayslipService service = PayslipService();
                PayslipRequestModel payslipRequestModel = PayslipRequestModel(
                    year: widget.payslip.hsJaar,
                    period: widget.payslip.hsPeriode);
                String bytes =
                    await service.getPayslipFile(payslipRequestModel);
                if (bytes == ConstantUtil.TOKEN_EXPIRED ||
                    bytes == ConstantUtil.NO_INTERNET ||
                    bytes == ConstantUtil.SERVICE_UNAVAILABLE ||
                    bytes == ConstantUtil.BAD_REQUEST ||
                    bytes == ConstantUtil.SOMETHING_WRONG ||
                    bytes == ConstantUtil.FORBIDDEN ||
                    bytes == ConstantUtil.NOT_FOUND ||
                    bytes == ConstantUtil.REQUEST_TIMEOUT ||
                    bytes == ConstantUtil.INTERNAL_SERVER_ERROR) {
                  errorMessage = bytes;
                  SnackBar snackBar = SnackBar(
                    content: SizedBox(
                        height: 40,
                        child: Column(children: [
                          Text(
                            AppLocalizations.of(context)!.cantDownload,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            AppLocalizations.of(context)!.error +
                                ": " +
                                errorMessage,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                        ])),
                    backgroundColor: Colors.redAccent,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  setState(() {
                    isApiCallProcess = false;
                  });
                } else {
                  _createPdf(bytes, filepath);
                  setState(() {
                    isApiCallProcess = false;
                  });
                }
              },
              icon: Icon(
                Icons.download_outlined,
                color: RainbowColor.primary_1,
              )),
        ],
      ),
      // drawer: const Navigation(),
      body: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3.0),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.amount,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: RainbowTextStyle.fontFamily,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    )),
                Text(
                  widget.payslip.vaCode.toString() +
                      " " +
                      widget.payslip.hsBedrag1.toString(),
                  style: TextStyle(
                    color: RainbowColor.primary_1,
                    fontFamily: RainbowTextStyle.fontFamily,
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Column(children: [
                RTextField(
                  title: AppLocalizations.of(context)!.period,
                  data_1: widget.payslip.hsPeriode.toString(),
                  fontSize: 18,
                  color_1: RainbowColor.primary_2,
                ),
                RTextField(
                  title: AppLocalizations.of(context)!.periodFrom,
                  data_1: showDate(widget.payslip.peDatumVan),
                  fontSize: 18,
                  color_1: RainbowColor.primary_2,
                ),
                RTextField(
                  title: AppLocalizations.of(context)!.periodTo,
                  data_1: showDate(widget.payslip.peDatumTm),
                  fontSize: 18,
                  color_1: RainbowColor.primary_2,
                ),
                RTextField(
                  title: AppLocalizations.of(context)!.country,
                  data_1: widget.payslip.beLand,
                  fontSize: 18,
                  color_1: RainbowColor.primary_2,
                ),
                RTextField(
                  title: AppLocalizations.of(context)!.empCode,
                  data_1: widget.payslip.emCode.toString(),
                  fontSize: 18,
                  color_1: RainbowColor.primary_2,
                ),
                RTextField(
                  title: AppLocalizations.of(context)!.idNumber,
                  data_1: widget.payslip.emIdNr,
                  fontSize: 18,
                  color_1: RainbowColor.primary_2,
                ),
                RTextField(
                  title: AppLocalizations.of(context)!.bank,
                  data_1: widget.payslip.hsBank1,
                  fontSize: 18,
                  color_1: RainbowColor.primary_2,
                ),
                RTextField(
                  title: AppLocalizations.of(context)!.accountNumb,
                  data_1: widget.payslip.hsRekening1,
                  fontSize: 18,
                  color_1: RainbowColor.primary_2,
                ),
                RTextField(
                  title: AppLocalizations.of(context)!.position,
                  data_1: widget.payslip.fuOmschrijving,
                  fontSize: 18,
                  color_1: RainbowColor.primary_2,
                ),
                RTextField(
                  title: AppLocalizations.of(context)!.hourlyWage,
                  data_1: "(" +
                      widget.payslip.vaCode.toString() +
                      ") " +
                      widget.payslip.emUurLoon.toString(),
                  fontSize: 18,
                  color_1: RainbowColor.primary_2,
                ),
                RTextField(
                  title: AppLocalizations.of(context)!.empByWage,
                  data_1: "(" +
                      widget.payslip.vaCode.toString() +
                      ") " +
                      widget.payslip.emPerLoon.toString(),
                  fontSize: 18,
                  color_1: RainbowColor.primary_2,
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  String showDate(DateTime? date) {
    String formatter = DateFormat.yMMMMd().format(date!);
    return formatter;
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
