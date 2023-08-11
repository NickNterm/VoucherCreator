import 'package:dartz/dartz.dart';
import 'package:voucher_creator/core/failures/failure.dart';
import 'package:voucher_creator/features/main_feature/data/data_source/main_local_data_source.dart';
import 'package:voucher_creator/features/main_feature/data/model/pdf_data_model.dart';
import 'package:voucher_creator/features/main_feature/domain/repositories/main_repository.dart';

class MainRepositoryImpl extends MainRepository {
  final MainLocalDataSource localDataSource;

  MainRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, bool>> createPDF(PDFDataModel pdfData) async {
    try {
      await localDataSource.savePDF(await pdfData.toPDF(), pdfData.id);
      await localDataSource.cacheData(pdfData);
      return const Right(true);
    } catch (e) {
      print(e);
      return Left(
        Failure(message: 'Error creating PDF'),
      );
    }
  }

  @override
  Future<Either<Failure, List<PDFDataModel>>> loadCache() async {
    try {
      final pdfData = await localDataSource.loadCache();
      return Right(pdfData);
    } catch (e) {
      return Left(
        Failure(message: 'Error loading cache'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> deletePDF(int id) async {
    try {
      await localDataSource.deletePDF(id);
      return const Right(true);
    } catch (e) {
      return Left(
        Failure(message: 'Error deleting PDF'),
      );
    }
  }
}
