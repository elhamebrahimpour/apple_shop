import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/data/repository/product_category_repository.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'product_category_event.dart';
part 'product_category_state.dart';

class ProductCategoryBloc
    extends Bloc<ProductCategoryEvent, ProductCategoryState> {
  final IProductCategoryRepository _productCategoryRepository =
      serviceLocator.get();
  ProductCategoryBloc() : super(ProductCategoryLoading()) {
    on<ProductCategoryRequestedEvent>((event, emit) async {
      var productsByCategoryId = await _productCategoryRepository
          .getProductsByCategoryId(event.categoryId);
      emit(ProductCategoryResponse(productsByCategoryId));
    });
  }
}
