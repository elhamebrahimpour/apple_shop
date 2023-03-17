import 'package:apple_shop/data/model/product_gallery_image.dart';
import 'package:apple_shop/data/model/product_variants.dart';
import 'package:apple_shop/data/model/variant.dart';
import 'package:apple_shop/data/model/variant_types.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IProductDetailDatasource {
  Future<List<ProductImage>> getImageGallery(String productId);
  Future<List<VariantTypes>> getVariantTypes();
  Future<List<Variant>> getVariants();
  Future<List<ProductVaraint>> getProductVariants();
}

class ProductDetailRemoteDatasource extends IProductDetailDatasource {
  final Dio _dio = serviceLocator.get();
  @override
  Future<List<ProductImage>> getImageGallery(String productId) async {
    try {
      Map<String, String> queryParams = {'filter': 'product_id="$productId"'};
      final response = await _dio.get('collections/gallery/records',
          queryParameters: queryParams);
      return response.data['items']
          .map<ProductImage>((jsonObject) => ProductImage.fromJson(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error!');
    }
  }

  @override
  Future<List<VariantTypes>> getVariantTypes() async {
    try {
      final response = await _dio.get('collections/variants_type/records');
      return response.data['items']
          .map<VariantTypes>((jsonObject) => VariantTypes.fromJson(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error!');
    }
  }

  @override
  Future<List<Variant>> getVariants() async {
    try {
      final response = await _dio.get('collections/variants/records');
      return response.data['items']
          .map<Variant>((jsonObject) => Variant.fromJson(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error!');
    }
  }

  @override
  Future<List<ProductVaraint>> getProductVariants() async {
    List<VariantTypes> variantTypesList = await getVariantTypes();
    List<Variant> variantList = await getVariants();

    List<ProductVaraint> productVariantList = [];
    try {
      for (var currentVariantType in variantTypesList) {
        var currentVariantList = variantList
            .where((element) => element.typeId == currentVariantType.id)
            .toList();
        productVariantList
            .add(ProductVaraint(currentVariantType, currentVariantList));
      }

      return productVariantList;
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error!');
    }
  }
}
