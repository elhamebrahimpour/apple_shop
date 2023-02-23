part of 'product_bloc.dart';

abstract class ProductState {}

class ProductDetailInitialState extends ProductState {}

class ProductDetailLoadingState extends ProductState {}

class ProductDetailResponseState extends ProductState {
  Either<String, List<ProductImage>> productImages;
  ProductDetailResponseState(this.productImages);
}
