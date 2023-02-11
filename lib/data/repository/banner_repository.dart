import 'package:apple_shop/data/datasource/banner_datasource.dart';
import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IBannerRepository {
  Future<Either<String, List<Banner>>> getBanners();
}

class BannerRepository extends IBannerRepository {
  final IBannerDatasource _datasource = serviceLocator.get();
  @override
  Future<Either<String, List<Banner>>> getBanners() async {
    try {
      var response = await _datasource.getBanners();
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'Failed!');
    }
  }
}
