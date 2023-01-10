import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthenticationRemote {
  final Dio _dio = locator.get();

  Future<void> register(
      String username, String password, String passwordConfirm) async {
    try {
      final response = await _dio.post('collections/users/records', data: {
        'username': username,
        'password': password,
        'passwordConfirm': passwordConfirm,
      });
      if (kDebugMode) {
        print(response.statusCode);
      }
    } on DioError catch (ex) {
      //print(ex.response!.statusCode);
      //print(ex.response!.data['message']);
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
