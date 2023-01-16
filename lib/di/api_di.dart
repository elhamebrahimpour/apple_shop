import 'package:apple_shop/data/datasource/authentication_datasource.dart';
import 'package:apple_shop/data/repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var serviceLocator = GetIt.instance;

Future getApiInit() async {
  serviceLocator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')));

  serviceLocator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  serviceLocator
      .registerFactory<IAuthenticationRemote>(() => AuthenticationRemote());

  serviceLocator.registerFactory<IAuthenticationRepository>(
      () => AuthenticationRepository());
}
