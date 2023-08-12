import 'package:path_provider/path_provider.dart';

const pdfPath = 'VoucherCreator';

getPDFPath() async {
  final path = await getExternalStorageDirectory();
  String pathString = path!.path + "/" + pdfPath;
  print("path is " + pathString);
  return pathString;
}
