// import 'dart:html';
import 'dart:io';
import 'dart:typed_data';

// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../Backend/Models/Payslip.dart';
import '../../../Theme/ThemeColor.dart';
import '../../../Theme/ThemeTextStyle.dart';

class FileViewer extends StatefulWidget {
  File payslip;
  String title;
  FileViewer({
    Key? key,
    required this.payslip,
    required this.title,
  }) : super(key: key);

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
    return Scaffold(
        body: SfPdfViewer.file(
      widget.payslip,
      pageLayoutMode: PdfPageLayoutMode.single,
      enableDoubleTapZooming: true,
      initialZoomLevel: 1,
      controller: _pdfViewerController,
      canShowScrollHead: false,
      canShowScrollStatus: false,
      canShowPaginationDialog: false,
    ));
  }
}
