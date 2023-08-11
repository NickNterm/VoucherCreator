import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:voucher_creator/features/main_feature/data/model/pdf_data_model.dart';

class PreviewPage extends StatefulWidget {
  final PDFDataModel pdfData;

  const PreviewPage({super.key, required this.pdfData});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voucher ${widget.pdfData.id}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SfPdfViewer.file(
          File(
            '/storage/emulated/0/Documents/VoucherCreator/Voucher_${widget.pdfData.id}.pdf',
          ),
        ),
      ),
    );
  }
}
