import 'package:apple_shop/data/datasource/authentication_datasource.dart';
import 'package:apple_shop/data/datasource/banner_datasource.dart';
import 'package:apple_shop/data/datasource/category_datasource.dart';
import 'package:apple_shop/data/repository/authentication_repository.dart';
import 'package:apple_shop/data/repository/banner_repository.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var serviceLocator = GetIt.instance;

Future getItInit() async {
  serviceLocator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')));

  serviceLocator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

//app datasource
  serviceLocator.registerFactory<IAuthenticationDatasource>(
      () => AuthenticationRemoteDatasource());

  serviceLocator
      .registerFactory<ICategoryDatasource>(() => CategoryRemoteDatasource());

  serviceLocator
      .registerFactory<IBannerDatasource>(() => BannerRemoteDatasource());
//app repository
  serviceLocator.registerFactory<IAuthenticationRepository>(
      () => AuthenticationRepository());

  serviceLocator
      .registerFactory<ICategoryRepository>(() => CategoryRepository());

  serviceLocator.registerFactory<IBannerRepository>(() => BannerRepository());
}
