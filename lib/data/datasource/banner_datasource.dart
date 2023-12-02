import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/features/di/api_di.dart';
import 'package:apple_shop/features/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IBannerDatasource {
  Future<List<AdvertiseBanner>> getBanners();
}

class BannerRemoteDatasource extends IBannerDatasource {
  final Dio _dio = serviceLocator.get();
  @override
  Future<List<AdvertiseBanner>> getBanners() async {
    try {
      var response = await _dio.get('collections/banner/records');
      return response.data['items']
          .map<AdvertiseBanner>(
              (jsonObject) => AdvertiseBanner.fromJson(jsonObject))
          .toList();
    } on DioException catch (e) {
      throw ApiException(
        e.response!.statusCode,
        e.response!.data['message'] == 'Not Found.'
            ? 'خطای شبکه'
            : e.response!.data['message'],
      );
    } catch (ex) {
      throw ApiException(0, 'unknown error!');
    }
  }
}
