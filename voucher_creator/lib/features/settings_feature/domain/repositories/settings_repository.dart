import 'package:voucher_creator/features/settings_feature/data/models/settings_model.dart';

abstract class SettingsRepository {
  Future<void> setSettings(SettingsModel settings);
  Future<SettingsModel> getSettings();
}
