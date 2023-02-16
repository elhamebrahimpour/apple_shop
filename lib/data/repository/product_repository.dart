import 'package:apple_shop/data/datasource/category_datasource.dart';
import 'package:apple_shop/data/datasource/product_datasource.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IProductRepository {
  Future<Either<String, List<Product>>> getProducts();
}

class ProductRepository extends IProductRepository {
  final IProductDatasource _productDatasource = serviceLocator.get();
  @override
  Future<Either<String, List<Product>>> getProducts() async {
    try {
      var response = await _productDatasource.getAllProducts();
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'Failed!');
    }
  }
}
