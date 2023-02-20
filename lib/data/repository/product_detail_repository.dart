import 'package:apple_shop/data/datasource/product_detail_datasource.dart';
import 'package:apple_shop/data/model/product_gallery_image.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IProductDetailRepository {
  Future<Either<String, List<ProductImage>>> getImageGallery();
}

class ProductDetailRepository extends IProductDetailRepository {
  final IProductDetailDatasource _detailDatasource = serviceLocator.get();
  @override
  Future<Either<String, List<ProductImage>>> getImageGallery() async {
    try {
      final response = await _detailDatasource.getImageGallery();
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'Failed!');
    }
  }
}
