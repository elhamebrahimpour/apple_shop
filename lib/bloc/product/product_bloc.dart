import 'package:apple_shop/data/model/product_gallery_image.dart';
import 'package:apple_shop/data/repository/product_detail_repository.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductDetailRepository _detailRepository = serviceLocator.get();
  ProductBloc() : super(ProductDetailInitialState()) {
    on<ProductDetailInitialized>((event, emit) async {
      emit(ProductDetailLoadingState());
      var productImages = await _detailRepository.getImageGallery();
      emit(ProductDetailResponseState(productImages));
    });
  }
}
