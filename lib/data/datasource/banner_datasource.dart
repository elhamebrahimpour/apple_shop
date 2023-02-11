import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IBannerDatasource {
  Future<List<Banner>> getBanners();
}

class BannerRemoteDatasource extends IBannerDatasource {
  final Dio _dio = serviceLocator.get();
  @override
  Future<List<Banner>> getBanners() async {
    try {
      var response = await _dio.get('collections/banner/records');
      return response.data['items']
          .map<Banner>((jsonObject) => Banner.fromJson(jsonObject))
          .toList();
    } on DioError catch (e) {
      throw ApiException(e.response!.statusCode, e.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error!');
    }
  }
}
