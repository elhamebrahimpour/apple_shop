import 'package:apple_shop/data/datasource/product_datasource.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/core/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IProductRepository {
  Future<Either<String, List<Product>>> getProducts();
  Future<Either<String, List<Product>>> getBestSellerProducts();
  Future<Either<String, List<Product>>> getHotestProducts();
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

  @override
  Future<Either<String, List<Product>>> getBestSellerProducts() async {
    try {
      var response = await _productDatasource.getBestSellerProducts();
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'Failed!');
    }
  }

  @override
  Future<Either<String, List<Product>>> getHotestProducts() async {
    try {
      var response = await _productDatasource.getHotestProducts();
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'Failed!');
    }
  }
}
