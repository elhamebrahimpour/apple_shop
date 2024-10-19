import 'package:apple_shop/core/utils/auth_manager.dart';
import 'package:dio/dio.dart';

class DioProvider {
  static Dio createDioWithHeader() {
    return Dio(
      BaseOptions(
        baseUrl: 'https://startflutter.ir/api/',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthManager.readToken()}',
        },
      ),
    );
  }

  static Dio createDioWithoutHeader() {
    return Dio(
      BaseOptions(
        baseUrl: 'http://startflutter.ir/api/',
      ),
    );
  }
}
