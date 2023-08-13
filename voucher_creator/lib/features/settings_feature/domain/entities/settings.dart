import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  final String firstName;
  final String secondName;
  final String address;
  final String afm;

  const Settings({
    required this.firstName,
    required this.secondName,
    required this.address,
    required this.afm,
  });

  @override
  List<Object?> get props => [
        firstName,
        secondName,
        address,
        afm,
      ];
}
