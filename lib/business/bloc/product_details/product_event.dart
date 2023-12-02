part of 'product_bloc.dart';

abstract class ProductEvent {}

class ProductDetailInitialized extends ProductEvent {
  String productId;
  String categoryId;
  
  ProductDetailInitialized(this.productId, this.categoryId);
}

class ProductAddToCardEvent extends ProductEvent {
  final Product product;
  ProductAddToCardEvent(this.product);
}
