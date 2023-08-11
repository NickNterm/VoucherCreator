import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voucher_creator/features/main_feature/data/data_source/main_local_data_source.dart';
import 'package:voucher_creator/features/main_feature/data/repositories/main_repository_impl.dart';
import 'package:voucher_creator/features/main_feature/domain/repositories/main_repository.dart';
import 'package:voucher_creator/features/main_feature/domain/use_cases/create_pdf_use_case.dart';
import 'package:voucher_creator/features/main_feature/domain/use_cases/delete_pdf_use_case.dart';
import 'package:voucher_creator/features/main_feature/domain/use_cases/load_cache_use_case.dart';
import 'package:voucher_creator/features/main_feature/presentation/bloc/pdf_list/pdf_list_bloc.dart';
import 'package:voucher_creator/features/settings_feature/data/data_sources/settings_local_data_source.dart';
import 'package:voucher_creator/features/settings_feature/data/repositories/settings_repository_impl.dart';
import 'package:voucher_creator/features/settings_feature/domain/repositories/settings_repository.dart';
import 'package:voucher_creator/features/settings_feature/domain/use_cases/get_settings.dart';
import 'package:voucher_creator/features/settings_feature/domain/use_cases/save_settings.dart';
import 'package:voucher_creator/features/settings_feature/presentation/bloc/settings/settings_bloc.dart';

GetIt sl = GetIt.instance;
Future<void> depencyInjection() async {
  // Bloc
  sl.registerLazySingleton<PdfListBloc>(
    () => PdfListBloc(
      createPDFUseCase: sl(),
      loadCacheUseCase: sl(),
      deletePDFUseCase: sl(),
    ),
  );
  sl.registerLazySingleton<SettingsBloc>(
    () => SettingsBloc(
      getSettingsUseCase: sl(),
      saveSettingsUseCase: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<MainRepository>(
    () => MainRepositoryImpl(
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton<CreatePDFUseCase>(
    () => CreatePDFUseCase(sl()),
  );
  sl.registerLazySingleton<LoadCacheUseCase>(
    () => LoadCacheUseCase(sl()),
  );
  sl.registerLazySingleton<DeletePDFUseCase>(
    () => DeletePDFUseCase(sl()),
  );
  sl.registerLazySingleton<GetSettingsUseCase>(
    () => GetSettingsUseCase(sl()),
  );
  sl.registerLazySingleton<SaveSettingsUseCase>(
    () => SaveSettingsUseCase(sl()),
  );

  // Data sources
  sl.registerLazySingleton<MainLocalDataSource>(
    () => MainLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );
  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  // core
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
