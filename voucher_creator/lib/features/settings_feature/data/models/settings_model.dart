import 'package:voucher_creator/features/settings_feature/domain/entities/settings.dart';

class SettingsModel extends Settings {
  const SettingsModel({
    required super.firstName,
    required super.secondName,
    required super.address,
    required super.afm,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> data) {
    return SettingsModel(
      firstName: data["firstName"] ?? "",
      secondName: data["secondName"] ?? "",
      address: data["address"] ?? "",
      afm: data["afm"] ?? "",
    );
  }

  bool get isEmpty {
    return firstName.isEmpty &&
        secondName.isEmpty &&
        address.isEmpty &&
        afm.isEmpty;
  }

  SettingsModel copyWith({
    String? firstName,
    String? secondName,
    String? address,
    String? afm,
  }) {
    return SettingsModel(
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      address: address ?? this.address,
      afm: afm ?? this.afm,
    );
  }

  String toJson() {
    return '''
      { 
        "firstName": "$firstName",
        "secondName": "$secondName",
        "address": "$address",
        "afm": "$afm"
      }
      ''';
  }

  factory SettingsModel.def() {
    return const SettingsModel(
      firstName: '',
      secondName: '',
      address: '',
      afm: '',
    );
  }
}
