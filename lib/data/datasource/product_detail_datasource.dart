import 'package:apple_shop/data/model/product_gallery_image.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IProductDetailDatasource {
  Future<List<ProductImage>> getImageGallery();
}

class ProductDetailRemoteDatasource extends IProductDetailDatasource {
  final Dio _dio = serviceLocator.get();
  @override
  Future<List<ProductImage>> getImageGallery() async {
    try {
      final response = await _dio.get('collections/gallery/records');
      return response.data['items']
          .map<ProductImage>((jsonObject) => ProductImage.fromJson(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error!');
    }
  }
}
