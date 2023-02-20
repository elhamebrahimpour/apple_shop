import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/data/repository/banner_repository.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/data/repository/product_repository.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository = serviceLocator.get();
  final ICategoryRepository _categoryRepository = serviceLocator.get();
  final IProductRepository _productRepository = serviceLocator.get();
  HomeBloc() : super(HomeInitialState()) {
    on<HomeGetRequestedEvent>((event, emit) async {
      emit(HomeLoadingState());
      var bannerList = await _bannerRepository.getBanners();
      var categoryList = await _categoryRepository.getCategoryList();
      var productList = await _productRepository.getProducts();
      var bestSellerProductList =
          await _productRepository.getBestSellerProducts();
      var hotestProductList = await _productRepository.getHotestProducts();

      emit(HomeSuccessResponseState(bannerList, categoryList, productList,
          bestSellerProductList, hotestProductList));
    });
  }
}
