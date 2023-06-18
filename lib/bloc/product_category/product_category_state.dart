part of 'product_category_bloc.dart';

@immutable
abstract class ProductCategoryState {}

class ProductCategoryLoading extends ProductCategoryState {}

// ignore: must_be_immutable
class ProductCategoryResponse extends ProductCategoryState {
  Either<String, List<Product>> productsByCategoryId;
  ProductCategoryResponse(this.productsByCategoryId);
}
