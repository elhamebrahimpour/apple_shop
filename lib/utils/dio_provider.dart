import 'package:apple_shop/utils/auth_manager.dart';
import 'package:dio/dio.dart';

class DioProvider {
  Dio createDio() {
    return Dio(
      BaseOptions(
        baseUrl: 'http://startflutter.ir/api/',
        /* headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthManager.readToken()}',
        },*/
      ),
    );
  }
}
