import 'package:apple_shop/features/utils/api_exception.dart';
import 'package:apple_shop/features/utils/auth_manager.dart';
import 'package:apple_shop/features/utils/dio_provider.dart';
import 'package:dio/dio.dart';

//this class sends request to the server and handles the error via sending request
//DataSource

abstract class IAuthenticationDatasource {
  Future<void> register(
      String username, String password, String passwordConfirm);

  Future<String> login(String username, String password);
}

class AuthenticationRemoteDatasource implements IAuthenticationDatasource {
  final Dio _dio = DioProvider.createDioWithoutHeader();

//send registeration request to the server
  @override
  Future<void> register(
      String username, String password, String passwordConfirm) async {
    try {
      final response = await _dio.post(
        'collections/users/records',
        data: {
          'username': username,
          'name': username,
          'password': password,
          'passwordConfirm': passwordConfirm
        },
      );
      if (response.statusCode == 200) {
        login(username, password);
      }
    } on DioException catch (e) {
      throw ApiException(
        e.response!.statusCode,
        e.response!.data['message'],
        response: e.response,
      );
    } catch (ex) {
      throw ApiException(0, 'unknown error!');
    }
  }

  @override
  Future<String> login(String username, String password) async {
    try {
      final response = await _dio.post(
        'collections/users/auth-with-password',
        data: {
          'identity': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        AuthManager.saveUserId(response.data['record']['id']);

        AuthManager.saveToken(response.data?['token']);

        return response.data?['token'];
      }
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error!');
    }
    return '';
  }
}
