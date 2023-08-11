import 'package:dartz/dartz.dart';
import 'package:voucher_creator/core/failures/failure.dart';
import 'package:voucher_creator/features/main_feature/data/model/pdf_data_model.dart';

abstract class MainRepository {
  Future<Either<Failure, List<PDFDataModel>>> loadCache();
  Future<Either<Failure, bool>> createPDF(PDFDataModel pdfData);
  Future<Either<Failure, bool>> deletePDF(int id);
}
