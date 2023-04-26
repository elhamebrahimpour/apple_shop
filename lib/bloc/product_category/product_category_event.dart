part of 'product_category_bloc.dart';

@immutable
abstract class ProductCategoryEvent {}

class ProductCategoryRequestedEvent extends ProductCategoryEvent {
  String categoryId;
  ProductCategoryRequestedEvent(this.categoryId);
}
