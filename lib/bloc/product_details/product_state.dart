part of 'product_bloc.dart';

abstract class ProductState {}

class ProductDetailInitialState extends ProductState {}

class ProductDetailLoadingState extends ProductState {}

class ProductDetailResponseState extends ProductState {
  Either<String, List<ProductImage>> productImages;
  Either<String, List<ProductVaraint>> productVariants;
  Either<String, Category> productCategory;
  Either<String, List<Property>> productProperties;
  ProductDetailResponseState(this.productImages, this.productVariants,
      this.productCategory, this.productProperties);
}

class ProductCardResponseState extends ProductState {}
