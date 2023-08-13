import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:voucher_creator/features/main_feature/domain/entities/pdf_data.dart';
import 'package:voucher_creator/features/settings_feature/domain/entities/settings.dart';
import 'package:voucher_creator/features/settings_feature/presentation/bloc/settings/settings_bloc.dart';
import 'package:voucher_creator/injection.dart';

class PDFDataModel extends PDFData {
  const PDFDataModel({
    required super.id,
    required super.date,
    required super.startHour,
    required super.endHour,
    required super.startLocation,
    required super.endLocation,
    required super.amount,
    required super.names,
  });

  String toJson() {
    String listNames = "";
    for (var i = 0; i < names.length; i++) {
      listNames += names[i];
      if (i != names.length - 1) {
        listNames += "~";
      }
    }
    return '''
      { 
        "id": $id,
        "date": "$date",
        "startHour": "$startHour",
        "endHour": "$endHour",
        "startLocation": "$startLocation",
        "endLocation": "$endLocation",
        "amount": "$amount",
        "names": "$listNames"
      }
      ''';
  }

  factory PDFDataModel.fromJson(Map<String, dynamic> data) {
    List<String> listNames = [];
    for (var name in data["names"].split("~")) {
      listNames.add(name);
    }
    return PDFDataModel(
      id: data["id"],
      date: data["date"],
      startHour: data["startHour"],
      endHour: data["endHour"],
      startLocation: data["startLocation"],
      endLocation: data["endLocation"],
      amount: data["amount"],
      names: listNames,
    );
  }

  Future<pw.Document> toPDF() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String path = dir.path;
    final File imageFile = File('$path/signature.png');
    final File imageFile2 = File('$path/signatureB.png');
    final Settings settings = sl<SettingsBloc>().state;
    final pdf = pw.Document(
      theme: pw.ThemeData.withFont(
        bold: pw.Font.ttf(
          await rootBundle.load(
            "assets/fonts/Calibri Bold.ttf",
          ),
        ),
        base: pw.Font.ttf(
          await rootBundle.load(
            "assets/fonts/Calibri Regular.ttf",
          ),
        ),
      ),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Stack(
            children: [
              pw.Positioned(
                top: 0,
                left: 0,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'ΑΡΙΘΜΟΣ\nΣΥΜΒΑΣΗΣ',
                    ),
                    pw.SizedBox(height: 10),
                    pw.Container(
                      width: 110,
                      height: 30,
                      alignment: pw.Alignment.center,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          width: 1,
                        ),
                      ),
                      child: pw.Text(
                        "$id",
                        style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              pw.Positioned(
                top: 0,
                right: 0,
                child: pw.Column(
                  children: [
                    pw.Text(
                      "Τ.Π.Υ ……………………",
                    ),
                    pw.Text(
                      "Α.Τ.Υ ……………………",
                    ),
                  ],
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 100,
                ),
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Container(
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(width: 1),
                        ),
                      ),
                      child: pw.Text(
                        "ΑΡΙΘΜΟΣ ΚΥΚΛΟΦΟΡΙΑΣ",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Container(
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(width: 1),
                        ),
                      ),
                      child: pw.Text(
                        "ΤΑΕ 6213",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Text(
                      "ΣΥΜΒΑΣΗ ΠΑΡΟΧΗΣ ΥΠΗΡΕΣΙΩΝ Ε.Δ.Χ",
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    pw.Text(
                      "ΕΙΔΙΚΗΣ ΜΙΣΘΩΣΗΣ (ΜΕΡΙΚΗΣ ΕΚΜΙΣΘΩΣΗΣ)",
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    pw.Text(
                      "Στα Ιωάννινα την $date. μεταξύ αφενός",
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    pw.Bullet(
                      text:
                          "Του ${settings.firstName} με την επωνυμία ${settings.secondName} και διακριτικό τίτλο-δραστηριότητα (ΕΚΜΕΤΑΛΕΥΤΗΣ ΤΑΞΙ ΤΑΕ 6213) που εδρεύει στην ${settings.address} στα Ιωάννινα (Νομός Ιωαννίνων) με Α.Φ.Μ ${settings.afm}.",
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    pw.Text(
                      "και αφετέρου",
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    pw.Bullet(
                      text: names.join(", "),
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    pw.Container(
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(width: 1),
                        ),
                      ),
                      child: pw.Text(
                        "ΧΡΟΝΟΣ-ΠΕΡΙΓΡΑΦΗ ΚΑΙ ΑΞΙΑ ΜΙΣΘΩΣΗΣ",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Text(
                      "Συμφωνείται μεταξύ των ανωτέρω συμβαλλομένων η παροχή υπηρεσιών ΕΙΔΙΚΗΣ ΜΙΣΘΩΣΗΣ σύμφωνα με τον Ν.4070/2012 ΦΕΚ 82Α/10-04-12 αρθ.82.παρ.8 με έναρξη του χρόνου ΜΙΣΘΩΣΗΣ την $date και ώρα $startHour και λήξη την $endHour. Η παροχή υπηρεσιών ΕΙΔΙΚΗΣ ΜΙΣΘΩΣΗΣ περιλαμβάνει την μεταφορά του ΜΙΣΘΩΤΗ από $startLocation προς $endLocation. Το ποσό της μίσθωσης για τη μεταφορά ανέρχεται στα $amount ΕΥΡΩ ΜΕ Φ.Π.Α",
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 11,
                      ),
                    ),
                    pw.Text(
                      "ο παρόν συντάχθηκε σε δύο (2) όμοια αντίγραφα και αφού αναγνώσθηκε και βεβαιώθηκε το περιεχόμενο του από τους συμβαλλόμενους υπογράφεται από αυτούς ως έπεται, έλαβε δε έκαστος από ένα (1) όμοιο αντίγραφο",
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
              ),
              pw.Positioned(
                bottom: 0,
                left: 0,
                child: pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    pw.Text(
                      "Υπογραφή α",
                      style: const pw.TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    pw.Image(
                      pw.MemoryImage(
                        Uint8List.fromList(
                          imageFile.readAsBytesSync(),
                        ),
                      ),
                      height: 80,
                    ),
                  ],
                ),
              ),
              pw.Positioned(
                bottom: 0,
                right: 0,
                child: pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    pw.Text(
                      "Υπογραφή β",
                      style: const pw.TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    pw.Image(
                      pw.MemoryImage(
                        Uint8List.fromList(
                          imageFile2.readAsBytesSync(),
                        ),
                      ),
                      height: 80,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
    return pdf;
  }
}
