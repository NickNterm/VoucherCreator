import 'package:dartz/dartz.dart';
import 'package:voucher_creator/core/failures/failure.dart';
import 'package:voucher_creator/features/main_feature/domain/repositories/main_repository.dart';

class DeletePDFUseCase {
  final MainRepository repository;

  DeletePDFUseCase(this.repository);

  Future<Either<Failure, bool>> call(int id) async {
    return await repository.deletePDF(id);
  }
}
