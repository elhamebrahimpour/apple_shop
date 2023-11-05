import 'package:apple_shop/data/datasource/authentication_datasource.dart';
import 'package:apple_shop/di/api_di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:dartz/dartz.dart';

//this class handles the response from the server which can be data or error
abstract class IAuthenticationRepository {
  Future<Either<String, String>> registerUser(
      String username, String password, String passwordConfirm);

  Future<Either<String, String>> loginUser(String username, String password);
}

class AuthenticationRepository extends IAuthenticationRepository {
  final IAuthenticationDatasource _dataSource = serviceLocator.get();
  @override
  Future<Either<String, String>> loginUser(
      String username, String password) async {
    try {
      String token = await _dataSource.login(username, password);
      if (token.isNotEmpty) {
        return right('Successfull user login!');
      } else {
        return left('ّFailed to log into the app');
      }
    } on ApiException catch (e) {
      return left(e.message ?? 'Failed!');
    }
  }

//handles user registration action as well as exceptions
  @override
  Future<Either<String, String>> registerUser(
      String username, String password, String passwordConfirm) async {
    try {
      await _dataSource.register(username, password, passwordConfirm);
      return right('Successfull user registration!');
    } on ApiException catch (e) {
      return left(e.message ?? 'Failed!');
    }
  }
}
