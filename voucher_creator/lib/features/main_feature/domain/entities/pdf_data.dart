import 'package:equatable/equatable.dart';

class PDFData extends Equatable {
  final int id;
  final String date;
  final String startHour;
  final String endHour;
  final String startLocation;
  final String endLocation;
  final String amount;
  final List<String> names;

  const PDFData({
    required this.id,
    required this.date,
    required this.startHour,
    required this.endHour,
    required this.startLocation,
    required this.endLocation,
    required this.amount,
    required this.names,
  });

  @override
  List<Object?> get props => [
        id,
        date,
        startHour,
        endHour,
        startLocation,
        endLocation,
        amount,
        names,
      ];
}
