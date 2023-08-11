import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  final String firstName;
  final String secondName;

  const Settings({
    required this.firstName,
    required this.secondName,
  });

  @override
  List<Object?> get props => [
        firstName,
        secondName,
      ];
}
