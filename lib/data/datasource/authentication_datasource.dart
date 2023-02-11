import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

//this class sends request to the server and handles the error via sending request
//DataSource

abstract class IAuthenticationDatasource {
  Future<void> register(
      String username, String password, String passwordConfirm);
  Future<String> login(String username, String password);
}

class AuthenticationRemoteDatasource implements IAuthenticationDatasource {
  final Dio _dio = serviceLocator.get();

//send registeration request to the server
  @override
  Future<void> register(
      String username, String password, String passwordConfirm) async {
    try {
      final response = await _dio.post('collections/users/records', data: {
        'username': username,
        'password': password,
        'passwordConfirm': passwordConfirm
      });
      if (kDebugMode) {
        print(response.statusCode);
      }
    } on DioError catch (e) {
      throw ApiException(e.response!.statusCode, e.response!.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error!');
    }
  }

  @override
  Future<String> login(String username, String password) async {
    try {
      final response = await _dio.post('collections/users/auth-with-password',
          data: {'identity': username, 'password': password});
      if (response.statusCode == 200) {
        return response.data?['token'];
      }
    } on DioError catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error!');
    }
    return '';
  }
}
