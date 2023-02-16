part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessResponseState extends HomeState {
  Either<String, List<AdvertiseBanner>> banners;
  Either<String, List<Category>> categories;
  Either<String, List<Product>> products;
  HomeSuccessResponseState(this.banners, this.categories, this.products);
}
