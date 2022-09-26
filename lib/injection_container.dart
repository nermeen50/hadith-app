import 'package:get_it/get_it.dart';
import 'package:hadith_app/config/common/shared_prefrance.dart';
import 'package:hadith_app/core/local_api/local_consumer.dart';
import 'package:hadith_app/core/local_api/local_service.dart';
import 'package:hadith_app/features/data/data_sources/hadith_data_source.dart';
import 'package:hadith_app/features/data/repository/hadith_repository_impl.dart';
import 'package:hadith_app/features/domain/repository/hadith_repository.dart';
import 'package:hadith_app/features/domain/usecases.dart/hadith_usecase.dart';
import 'package:hadith_app/features/presentation/bloc/cubit/hadith_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> init() async {
  /// Blocs
  sl.registerFactory<HadithCubit>(() => HadithCubit(
      hadith: sl(), sharedPreferences: sl(), preferences: Preferences()));

  /// Use Case
  sl.registerLazySingleton(() => HadithUseCase(hadithRepository: sl()));

  /// Repository
  sl.registerLazySingleton<HadithRepository>(
      () => HadithRepositoryImpl(hadithDataSource: sl()));

  /// Data Source
  sl.registerLazySingleton<HadithDataSource>(
      () => HadithDataSourceImpl(apiConsumer: sl()));

  /// Core
  sl.registerLazySingleton<ApiConsumer>(() => LocalService());

  /// external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Preferences());
}
