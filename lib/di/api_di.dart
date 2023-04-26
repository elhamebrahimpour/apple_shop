import 'package:apple_shop/data/datasource/authentication_datasource.dart';
import 'package:apple_shop/data/datasource/banner_datasource.dart';
import 'package:apple_shop/data/datasource/category_datasource.dart';
import 'package:apple_shop/data/datasource/product_category_datasource.dart';
import 'package:apple_shop/data/datasource/product_datasource.dart';
import 'package:apple_shop/data/datasource/product_detail_datasource.dart';
import 'package:apple_shop/data/repository/authentication_repository.dart';
import 'package:apple_shop/data/repository/banner_repository.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/data/repository/product_category_repository.dart';
import 'package:apple_shop/data/repository/product_detail_repository.dart';
import 'package:apple_shop/data/repository/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var serviceLocator = GetIt.instance;

Future getItInit() async {
  serviceLocator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')));

  serviceLocator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

//app datasources
  serviceLocator.registerFactory<IAuthenticationDatasource>(
      () => AuthenticationRemoteDatasource());

  serviceLocator
      .registerFactory<ICategoryDatasource>(() => CategoryRemoteDatasource());

  serviceLocator
      .registerFactory<IBannerDatasource>(() => BannerRemoteDatasource());

  serviceLocator
      .registerFactory<IProductDatasource>(() => ProductRemoteDatasource());

  serviceLocator.registerFactory<IProductDetailDatasource>(
      () => ProductDetailRemoteDatasource());

  serviceLocator.registerFactory<IProductCategoryDataSource>(
      () => ProductCategoryDataSource());

//app repositories
  serviceLocator.registerFactory<IAuthenticationRepository>(
      () => AuthenticationRepository());

  serviceLocator
      .registerFactory<ICategoryRepository>(() => CategoryRepository());

  serviceLocator.registerFactory<IBannerRepository>(() => BannerRepository());

  serviceLocator.registerFactory<IProductRepository>(() => ProductRepository());

  serviceLocator.registerFactory<IProductDetailRepository>(
      () => ProductDetailRepository());

  serviceLocator.registerFactory<IProductCategoryRepository>(
      () => ProductCategoryRepository());
}
