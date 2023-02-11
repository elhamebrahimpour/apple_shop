import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class ICategoryDatasource {
  Future<List<Category>> getCategoryList();
}

class CategoryRemoteDatasource extends ICategoryDatasource {
  final Dio _dio = serviceLocator.get();
  @override
  Future<List<Category>> getCategoryList() async {
    try {
      var response = await _dio.get('collections/category/records');
      return response.data['items']
          .map<Category>((jsonObject) => Category.fromJsonMap(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response!.statusCode, e.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error!');
    }
  }
}
