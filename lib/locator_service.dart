import 'package:get_it/get_it.dart';
import 'package:intexgram/Data/datasources/person_local_datasource.dart';
import 'package:intexgram/Data/datasources/person_remote_datasource.dart';
import 'package:intexgram/Data/repositories/person_repository_impl.dart';
import 'package:intexgram/Domain/repositories/person_repository.dart';
import 'package:intexgram/Domain/usecases/get_current_person_use_case.dart';
import 'package:intexgram/Domain/usecases/set_current_person_use_case.dart';
import 'package:intexgram/Presentation/Routes/auth_guard.dart';
import 'package:intexgram/core/platform/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Presentation/Routes/router.gr.dart';

final serverLocator = GetIt.instance;

Future<void> init() async {
  //BLoC

  //UseCases
  serverLocator
      .registerLazySingleton(() => GetCurrentPersonUseCase(serverLocator()));
  serverLocator
      .registerLazySingleton(() => SetCurrentPersonUseCase(serverLocator()));

  //Repository
  serverLocator.registerLazySingleton<PersonRepository>(() =>
      PersonRepositoryImpl(
          localDataSource: serverLocator(),
          remoteDataSource: serverLocator(),
          networkInfo: serverLocator()));

  serverLocator.registerLazySingleton<PersonRemoteDataSource>(
      () => PersonRemoteDataSourceImpl());

  serverLocator.registerLazySingleton<PersonLocalDataSource>(
      () => PersonLocalDataSourceImpl(sharedPreferences: serverLocator()));

  //Core
  serverLocator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  //Routes
  final flutterRouter = FlutterRouter(authGuard: AuthGuard());
  serverLocator.registerLazySingleton(() => flutterRouter);

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  serverLocator.registerLazySingleton(() => sharedPreferences);
}
