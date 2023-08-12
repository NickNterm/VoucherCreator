import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:voucher_creator/core/constants/storage_paths.dart';
import 'package:voucher_creator/features/main_feature/data/model/pdf_data_model.dart';

class PreviewPage extends StatefulWidget {
  final PDFDataModel pdfData;

  const PreviewPage({super.key, required this.pdfData});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  String pdfPath = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      pdfPath = await getPDFPath();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voucher ${widget.pdfData.id}"),
      ),
      body: Visibility(
        visible: pdfPath.isNotEmpty,
        child: SfPdfViewer.file(
          File(
            '$pdfPath/Voucher_${widget.pdfData.id}.pdf',
          ),
        ),
      ),
    );
  }
}
