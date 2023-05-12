import 'package:apple_shop/data/model/card_model.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/data/model/product_gallery_image.dart';
import 'package:apple_shop/data/model/product_properties.dart';
import 'package:apple_shop/data/model/product_variants.dart';
import 'package:apple_shop/data/repository/card_repository.dart';
import 'package:apple_shop/data/repository/product_detail_repository.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductDetailRepository _detailRepository = serviceLocator.get();
  final ICardLocalRepository _localRepository = serviceLocator.get();

  ProductBloc() : super(ProductDetailInitialState()) {
    on<ProductDetailInitialized>(
      (event, emit) async {
        emit(ProductDetailLoadingState());
        var productImages =
            await _detailRepository.getImageGallery(event.productId);
        var productVariants =
            await _detailRepository.getProductVariants(event.productId);
        var productCategory =
            await _detailRepository.getProductCategory(event.categoryId);
        var productProperties =
            await _detailRepository.getProductProperties(event.productId);

        emit(ProductDetailResponseState(productImages, productVariants,
            productCategory, productProperties));
      },
    );

    on<ProductAddToCardEvent>((event, emit) async {
      var cardItem = CardModel(
        event.product.categoryId,
        event.product.collectionId,
        event.product.id,
        event.product.name,
        event.product.thumbnail,
        event.product.price,
        event.product.discount_price,
      );
      await _localRepository.addProductToCard(cardItem);
    });
  }
}
