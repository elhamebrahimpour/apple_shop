import 'package:apple_shop/data/datasource/product_category_datasource.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/core/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IProductCategoryRepository {
  Future<Either<String, List<Product>>> getProductsByCategoryId(
      String categoryId);
}

class ProductCategoryRepository extends IProductCategoryRepository {
  final IProductCategoryDataSource _productCategoryDataSource =
      serviceLocator.get();

  @override
  Future<Either<String, List<Product>>> getProductsByCategoryId(
      String categoryId) async {
    try {
      var response =
          await _productCategoryDataSource.getProductsByCategoryId(categoryId);
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'Failed!');
    }
  }
}
