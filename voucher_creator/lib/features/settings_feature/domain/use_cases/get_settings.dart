import 'package:voucher_creator/features/settings_feature/domain/entities/settings.dart';
import 'package:voucher_creator/features/settings_feature/domain/repositories/settings_repository.dart';

class GetSettingsUseCase {
  final SettingsRepository _settingsRepository;

  GetSettingsUseCase(this._settingsRepository);

  Future<Settings> call() async {
    return await _settingsRepository.getSettings();
  }
}
