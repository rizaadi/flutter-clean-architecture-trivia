import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivia_clean_architecture/core/network/network_info.dart';
import 'package:trivia_clean_architecture/core/util/input_converter.dart';
import 'package:trivia_clean_architecture/feature/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:trivia_clean_architecture/feature/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:trivia_clean_architecture/feature/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:trivia_clean_architecture/feature/number_trivia/domain/respositories/number_trivia_repositories.dart';
import 'package:trivia_clean_architecture/feature/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:trivia_clean_architecture/feature/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:trivia_clean_architecture/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  sl.registerFactory(
    () => NumberTriviaBloc(
      concrete: sl(),
      random: sl(),
      inputConverter: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()),
  );
// Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
// Use cases
  sl.registerLazySingleton<GetConcreteNumberTrivia>(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton<GetRandomNumberTrivia>(() => GetRandomNumberTrivia(sl()));
  //! Core
  sl.registerLazySingleton<InputConverter>(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());
}
