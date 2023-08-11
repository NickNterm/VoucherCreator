import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:voucher_creator/core/constants/cache_keys.dart';
import 'package:voucher_creator/features/settings_feature/data/models/settings_model.dart';

abstract class SettingsLocalDataSource {
  Future<void> setSettings(SettingsModel settings);
  Future<SettingsModel> getSettings();
}

class SettingsLocalDataSourceImpl extends SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  SettingsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<SettingsModel> getSettings() async {
    String settingsString = sharedPreferences.getString(kSettingsKey) ?? "";
    if (settingsString == '') {
      return const SettingsModel(
        firstName: '',
        secondName: '',
      );
    }
    return SettingsModel.fromJson(jsonDecode(settingsString));
  }

  @override
  Future<void> setSettings(SettingsModel settings) async {
    await sharedPreferences.setString(kSettingsKey, settings.toJson());
  }
}
