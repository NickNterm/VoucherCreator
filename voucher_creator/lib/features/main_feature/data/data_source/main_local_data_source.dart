import 'dart:convert';
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voucher_creator/core/constants/cache_keys.dart';
import 'package:voucher_creator/features/main_feature/data/model/pdf_data_model.dart';

abstract class MainLocalDataSource {
  Future<bool> savePDF(pw.Document pdf, int id);
  Future<void> cacheData(PDFDataModel data);
  Future<List<PDFDataModel>> loadCache();
  Future<void> deletePDF(int id);
}

class MainLocalDataSourceImpl extends MainLocalDataSource {
  final SharedPreferences sharedPreferences;
  MainLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> savePDF(pw.Document pdf, int id) async {
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
        await Permission.manageExternalStorage.request();
      }
      if (!status.isGranted) {
        throw Exception();
      }
      if (!await Directory('/storage/emulated/0/Documents/VoucherCreator/')
          .exists()) {
        await Directory('/storage/emulated/0/Documents/VoucherCreator/')
            .create(recursive: true);
      }
      final file = File(
        '/storage/emulated/0/Documents/VoucherCreator/Voucher_$id.pdf',
      );
      if (await file.exists()) {
        await file.delete();
      }
      await file.writeAsBytes(await pdf.save());
      return true;
    } catch (e) {
      print("error saving pdf");
      print(e.toString());
      throw Exception();
    }
  }

  @override
  Future<void> cacheData(PDFDataModel data) async {
    List<String> pdfData = sharedPreferences.getStringList(kPDFDataKey) ?? [];
    List<PDFDataModel> pdfDataModel = pdfData
        .map(
          (e) => PDFDataModel.fromJson(
            jsonDecode(e),
          ),
        )
        .toList();
    for (int i = 0; i < pdfDataModel.length; i++) {
      if (pdfDataModel[i].id == data.id) {
        pdfData.removeAt(i);
        break;
      }
    }
    pdfData.add(data.toJson());
    await sharedPreferences.setStringList(kPDFDataKey, pdfData);
  }

  @override
  Future<List<PDFDataModel>> loadCache() {
    List<String> pdfData = sharedPreferences.getStringList(kPDFDataKey) ?? [];

    return Future.value(
      pdfData.map((e) => PDFDataModel.fromJson(jsonDecode(e))).toList(),
    );
  }

  @override
  Future<void> deletePDF(int id) async {
    List<String> pdfData = sharedPreferences.getStringList(kPDFDataKey) ?? [];
    List<PDFDataModel> pdfDataModel = pdfData
        .map(
          (e) => PDFDataModel.fromJson(
            jsonDecode(e),
          ),
        )
        .toList();
    for (int i = 0; i < pdfDataModel.length; i++) {
      if (pdfDataModel[i].id == id) {
        pdfData.removeAt(i);
        break;
      }
    }
    await sharedPreferences.setStringList(kPDFDataKey, pdfData);
  }
}
