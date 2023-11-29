import 'package:dio/dio.dart';
import 'package:flutter_tut_app/app/app_prefs.dart';
import 'package:flutter_tut_app/data/network/app_api.dart';
import 'package:flutter_tut_app/data/network/dio_factory.dart';
import 'package:flutter_tut_app/data/network/network_info.dart';
import 'package:flutter_tut_app/data/remote_data/remote_data.dart';
import 'package:flutter_tut_app/data/repository/repository_impl.dart';
import 'package:flutter_tut_app/domain/repository/repository.dart';
import 'package:flutter_tut_app/domain/usecase/login_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../representation/login/login_viewmodel.dart';

GetIt instance = GetIt.instance;

Future<void> initAppModule() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // shared preferences
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  // app preferences
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  // InternetConnectionChecker
  instance.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  // network info
  instance
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(instance()));
  // dio
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
  Dio dio = await instance<DioFactory>().getDio();
  // app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  // repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

Future<void> initLoginModule() async {
  if (!GetIt.I.isRegistered<LoginUsecase>()) {
    instance.registerFactory<LoginUsecase>(() => LoginUsecase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
