part of 'pdf_list_bloc.dart';

@immutable
abstract class PdfListEvent {}

class GetCachedPDFsEvent extends PdfListEvent {}

class CreatePDFEvent extends PdfListEvent {
  final PDFDataModel pdfData;

  CreatePDFEvent(this.pdfData);
}

class DeletePDFEvent extends PdfListEvent {
  final int id;

  DeletePDFEvent(this.id);
}
