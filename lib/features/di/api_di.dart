import 'package:apple_shop/business/bloc/shopping_card/card_bloc.dart';
import 'package:apple_shop/data/datasource/authentication_datasource.dart';
import 'package:apple_shop/data/datasource/banner_datasource.dart';
import 'package:apple_shop/data/datasource/card_datasource.dart';
import 'package:apple_shop/data/datasource/category_datasource.dart';
import 'package:apple_shop/data/datasource/comment_datasource.dart';
import 'package:apple_shop/data/datasource/product_category_datasource.dart';
import 'package:apple_shop/data/datasource/product_datasource.dart';
import 'package:apple_shop/data/datasource/product_detail_datasource.dart';
import 'package:apple_shop/data/repository/authentication_repository.dart';
import 'package:apple_shop/data/repository/banner_repository.dart';
import 'package:apple_shop/data/repository/card_repository.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/data/repository/comment_repository.dart';
import 'package:apple_shop/data/repository/product_category_repository.dart';
import 'package:apple_shop/data/repository/product_detail_repository.dart';
import 'package:apple_shop/data/repository/product_repository.dart';
import 'package:apple_shop/features/utils/dio_provider.dart';
import 'package:apple_shop/features/utils/payment_handler.dart';
import 'package:apple_shop/features/utils/url_handler.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var serviceLocator = GetIt.instance;

Future getItInit() async {
  await _initComponents();

  _initDatasources();

  _initRepositories();

  //bloc
  serviceLocator.registerSingleton<CardBloc>(
    CardBloc(
      serviceLocator.get(),
      serviceLocator.get(),
    ),
  );
}

Future<void> _initComponents() async {
  //payment part
  serviceLocator.registerSingleton<UrlLaunchHandler>(
    UrlLauncher(),
  );

  serviceLocator.registerSingleton<PaymentHandler>(
    ZarinPalPaymentHandler(
      serviceLocator.get(),
    ),
  );

  serviceLocator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  serviceLocator.registerSingleton<Dio>(DioProvider.createDioWithHeader());
}

//app datasources
void _initDatasources() {
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

  serviceLocator
      .registerFactory<ICardLocalDataSource>(() => CardLocalDataSource());

  serviceLocator.registerFactory<ICommentDatasource>(() => CommentDatasource());
}

//app repositories
void _initRepositories() {
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

  serviceLocator.registerFactory<ICardLocalRepository>(
    () => CardLocalRepository(
      serviceLocator.get(),
    ),
  );

  serviceLocator.registerFactory<ICommentRepository>(() => CommentRepository());
}
