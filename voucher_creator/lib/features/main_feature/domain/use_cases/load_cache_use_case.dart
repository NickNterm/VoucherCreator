import 'package:dartz/dartz.dart';
import 'package:voucher_creator/core/failures/failure.dart';
import 'package:voucher_creator/features/main_feature/data/model/pdf_data_model.dart';
import 'package:voucher_creator/features/main_feature/domain/repositories/main_repository.dart';

class LoadCacheUseCase {
  final MainRepository repository;

  LoadCacheUseCase(this.repository);

  Future<Either<Failure, List<PDFDataModel>>> call() async {
    return await repository.loadCache();
  }
}
