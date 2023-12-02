import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/data/repository/banner_repository.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/data/repository/product_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository;
  final ICategoryRepository _categoryRepository;
  final IProductRepository _productRepository;

  HomeBloc(
      this._bannerRepository, this._categoryRepository, this._productRepository)
      : super(HomeInitialState()) {
    on<HomeGetRequestedEvent>((event, emit) async {
      emit(HomeLoadingState());

      var banners = await _bannerRepository.getBanners();
      var categories = await _categoryRepository.getCategoryList();
      var products = await _productRepository.getProducts();

      var bestSellerProducts = await _productRepository.getBestSellerProducts();
      var hotestProducts = await _productRepository.getHotestProducts();

      emit(
        HomeResponseState(
          banners,
          categories,
          products,
          bestSellerProducts,
          hotestProducts,
        ),
      );
    });
  }
}
