import 'package:dartz/dartz.dart';
import 'package:voucher_creator/core/failures/failure.dart';
import 'package:voucher_creator/features/main_feature/data/model/pdf_data_model.dart';
import 'package:voucher_creator/features/main_feature/domain/repositories/main_repository.dart';

class CreatePDFUseCase {
  final MainRepository repository;

  CreatePDFUseCase(this.repository);

  Future<Either<Failure, bool>> call(PDFDataModel pdf) async {
    return await repository.createPDF(pdf);
  }
}
