import 'package:voucher_creator/features/settings_feature/data/data_sources/settings_local_data_source.dart';
import 'package:voucher_creator/features/settings_feature/data/models/settings_model.dart';
import 'package:voucher_creator/features/settings_feature/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  Future<SettingsModel> getSettings() async {
    return await localDataSource.getSettings();
  }

  @override
  Future<void> setSettings(SettingsModel settings) {
    return localDataSource.setSettings(settings);
  }
}
