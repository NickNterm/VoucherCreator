import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:voucher_creator/features/main_feature/data/model/pdf_data_model.dart';
import 'package:voucher_creator/features/main_feature/domain/entities/pdf_data.dart';
import 'package:voucher_creator/features/main_feature/domain/use_cases/create_pdf_use_case.dart';
import 'package:voucher_creator/features/main_feature/domain/use_cases/delete_pdf_use_case.dart';
import 'package:voucher_creator/features/main_feature/domain/use_cases/load_cache_use_case.dart';
part 'pdf_list_event.dart';

class PdfListBloc extends Bloc<PdfListEvent, List<PDFData>> {
  final CreatePDFUseCase createPDFUseCase;
  final LoadCacheUseCase loadCacheUseCase;
  final DeletePDFUseCase deletePDFUseCase;
  PdfListBloc({
    required this.createPDFUseCase,
    required this.loadCacheUseCase,
    required this.deletePDFUseCase,
  }) : super([]) {
    on<PdfListEvent>((event, emit) async {
      if (event is GetCachedPDFsEvent) {
        final result = await loadCacheUseCase();
        result.fold(
          (failure) => emit([]),
          (success) => emit(success),
        );
      } else if (event is CreatePDFEvent) {
        final result = await createPDFUseCase(event.pdfData);
        result.fold(
          (failure) => emit([]),
          (success) => add(GetCachedPDFsEvent()),
        );
      } else if (event is DeletePDFEvent) {
        final result = await deletePDFUseCase(event.id);
        result.fold(
          (failure) => emit([]),
          (success) => add(GetCachedPDFsEvent()),
        );
      }
    });
  }
}
