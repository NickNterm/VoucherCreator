import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:voucher_creator/features/settings_feature/data/models/settings_model.dart';
import 'package:voucher_creator/features/settings_feature/domain/use_cases/get_settings.dart';
import 'package:voucher_creator/features/settings_feature/domain/use_cases/save_settings.dart';

part 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsModel> {
  final GetSettingsUseCase getSettingsUseCase;
  final SaveSettingsUseCase saveSettingsUseCase;
  SettingsBloc({
    required this.getSettingsUseCase,
    required this.saveSettingsUseCase,
  }) : super(SettingsModel.def()) {
    on<SettingsEvent>((event, emit) async {
      if (event is SetSettingsEvent) {
        await saveSettingsUseCase(event.settings);
        emit(event.settings);
      } else if (event is GetSettingsEvent) {
        final result = await getSettingsUseCase();
        emit(result as SettingsModel);
      }
    });
  }
}
