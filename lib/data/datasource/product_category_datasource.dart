import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/features/di/api_di.dart';
import 'package:apple_shop/features/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IProductCategoryDataSource {
  Future<List<Product>> getProductsByCategoryId(String categoryId);
}

class ProductCategoryDataSource extends IProductCategoryDataSource {
  final Dio _dio = serviceLocator.get();
  @override
  Future<List<Product>> getProductsByCategoryId(String categoryId) async {
    try {
      Map<String, String> queryParams = {'filter': 'category= "$categoryId"'};
      Response<dynamic> response;
      if (categoryId == '78q8w901e6iipuk') {
        response = await _dio.get('collections/products/records');
      } else {
        response = await _dio.get('collections/products/records',
            queryParameters: queryParams);
      }
      return response.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error!');
    }
  }
}
