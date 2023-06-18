part of 'product_category_bloc.dart';

@immutable
abstract class ProductCategoryEvent {}

// ignore: must_be_immutable
class ProductCategoryRequestedEvent extends ProductCategoryEvent {
  String categoryId;
  ProductCategoryRequestedEvent(this.categoryId);
}
