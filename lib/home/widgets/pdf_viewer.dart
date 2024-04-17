import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatelessWidget {
  const PdfViewer(
    this.pdfFile, {
    super.key,
  });

  final File pdfFile;

  @override
  Widget build(BuildContext context) {
    return SfPdfViewer.file(
      pdfFile,
      pageLayoutMode: PdfPageLayoutMode.single,
    );
  }
}
