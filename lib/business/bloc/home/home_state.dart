part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeResponseState extends HomeState {
  Either<String, List<AdvertiseBanner>> banners;
  Either<String, List<Category>> categories;
  Either<String, List<Product>> products;
  Either<String, List<Product>> bestSellerproducts;
  Either<String, List<Product>> hotestproducts;

  HomeResponseState(
    this.banners,
    this.categories,
    this.products,
    this.bestSellerproducts,
    this.hotestproducts,
  );
}
