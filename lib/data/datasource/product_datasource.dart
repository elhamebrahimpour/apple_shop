import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IProductDatasource {
  Future<List<Product>> getAllProducts();
  Future<List<Product>> getBestSellerProducts();
  Future<List<Product>> getHotestProducts();
}

class ProductRemoteDatasource extends IProductDatasource {
  final Dio _dio = serviceLocator.get();
  @override
  Future<List<Product>> getAllProducts() async {
    try {
      var response = await _dio.get('collections/products/records');
      return response.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error!');
    }
  }

  @override
  Future<List<Product>> getBestSellerProducts() async {
    try {
      Map<String, String> queryParams = {'filter': 'popularity= "Best Seller"'};
      var response = await _dio.get('collections/products/records',
          queryParameters: queryParams);
      return response.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error!');
    }
  }

  @override
  Future<List<Product>> getHotestProducts() async {
    try {
      Map<String, String> queryParams = {'filter': 'popularity= "Hotest"'};
      var response = await _dio.get('collections/products/records',
          queryParameters: queryParams);
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
