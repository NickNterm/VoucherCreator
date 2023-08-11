import 'package:voucher_creator/features/settings_feature/domain/entities/settings.dart';

class SettingsModel extends Settings {
  const SettingsModel({
    required super.firstName,
    required super.secondName,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> data) {
    return SettingsModel(
      firstName: data["firstName"],
      secondName: data["secondName"],
    );
  }

  SettingsModel copyWith({
    String? firstName,
    String? secondName,
  }) {
    return SettingsModel(
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
    );
  }

  String toJson() {
    return '''
      { 
        "firstName": "$firstName",
        "secondName": "$secondName"
      }
      ''';
  }

  factory SettingsModel.def() {
    return const SettingsModel(
      firstName: '',
      secondName: '',
    );
  }
}
