import 'package:voucher_creator/features/settings_feature/data/models/settings_model.dart';
import 'package:voucher_creator/features/settings_feature/domain/repositories/settings_repository.dart';

class SaveSettingsUseCase {
  final SettingsRepository repository;

  SaveSettingsUseCase(this.repository);

  Future<void> call(SettingsModel settings) async {
    return await repository.setSettings(settings);
  }
}
