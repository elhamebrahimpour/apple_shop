import 'package:apple_shop/data/datasource/product_detail_datasource.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product_gallery_image.dart';
import 'package:apple_shop/data/model/product_variants.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IProductDetailRepository {
  Future<Either<String, List<ProductImage>>> getImageGallery(String productId);
  Future<Either<String, List<ProductVaraint>>> getProductVariants(
      String productId);
  Future<Either<String, Category>> getProductCategory(String categoryId);
}

class ProductDetailRepository extends IProductDetailRepository {
  final IProductDetailDatasource _detailDatasource = serviceLocator.get();
  @override
  Future<Either<String, List<ProductImage>>> getImageGallery(
      String productId) async {
    try {
      final response = await _detailDatasource.getImageGallery(productId);
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'Failed!');
    }
  }

  @override
  Future<Either<String, List<ProductVaraint>>> getProductVariants(
      String productId) async {
    try {
      final response = await _detailDatasource.getProductVariants(productId);
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'Failed!');
    }
  }

  @override
  Future<Either<String, Category>> getProductCategory(String categoryId) async {
    try {
      final response = await _detailDatasource.getProductCatgeory(categoryId);
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'Failed!');
    }
  }
}


  /* @override
  Future<Either<String, List<VariantTypes>>> getVariantTypes() async {
    try {
      final response = await _detailDatasource.getVariantTypes();
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'Failed!');
    }
  }

  @override
  Future<Either<String, List<Variant>>> getVariants() async {
    try {
      final response = await _detailDatasource.getVariants();
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'Failed!');
    }
  }*/
    /* Future<Either<String, List<VariantTypes>>> getVariantTypes();
  Future<Either<String, List<Variant>>> getVariants();*/