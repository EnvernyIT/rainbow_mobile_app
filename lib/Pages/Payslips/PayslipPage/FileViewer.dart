import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../Backend/Models/Payslip.dart';
import '../../../Theme/ThemeColor.dart';
import '../../../Theme/ThemeTextStyle.dart';

class FileViewer extends StatefulWidget {
  final Payslip payslip;
  FileViewer({Key? key, required this.payslip}) : super(key: key);

  @override
  State<FileViewer> createState() => _FileViewerState();
}

class _FileViewerState extends State<FileViewer> {
  PdfViewerController _pdfViewerController = PdfViewerController();

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PdfViewerController _pdfViewerController = PdfViewerController();
    final GlobalKey<SfPdfViewerState> _pdfViewerStateKey = GlobalKey();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: RainbowColor.secondary,
          foregroundColor: RainbowColor.primary_1,
          title: Text(
            widget.payslip.date.toString(),
            style: TextStyle(fontFamily: RainbowTextStyle.fontFamily),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  _pdfViewerStateKey.currentState!.openBookmarkView();
                },
                icon: Icon(
                  Icons.bookmark_outline,
                  color: RainbowColor.primary_1,
                )),
            IconButton(
                onPressed: () {
                  _pdfViewerController.jumpToPage(5);
                },
                icon: Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: RainbowColor.primary_1,
                )),
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_up,
                color: RainbowColor.primary_1,
              ),
              onPressed: () {
                _pdfViewerController.previousPage();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: RainbowColor.primary_1,
              ),
              onPressed: () {
                _pdfViewerController.nextPage();
              },
            )
          ],
        ),
        body: SfPdfViewer.network(
          widget.payslip.url,
          password: 'syncfusion',
          controller: _pdfViewerController,
          canShowScrollHead: false,
          canShowScrollStatus: false,
          canShowPaginationDialog: false,
        ),
      ),
    );
  }
}
