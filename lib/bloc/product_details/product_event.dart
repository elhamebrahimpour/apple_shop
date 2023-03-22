part of 'product_bloc.dart';

abstract class ProductEvent {}

class ProductDetailInitialized extends ProductEvent {
  String productId;
  String categoryId;
  ProductDetailInitialized(this.productId, this.categoryId);
}
