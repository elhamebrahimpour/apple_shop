import 'package:dio/dio.dart';

class ApiException {
  int? code;
  String? message;
  Response<dynamic>? response;

  ApiException(
    this.code,
    this.message, {
    this.response,
  }) {
    if (code != 400) {
      return;
    }

    //login error
    if (message == 'Failed to authenticate.') {
      message = 'نام کاربری یا رمز عبور اشتباه می‌باشد.';
    }

    //register errors
    if (message == 'Failed to create record.') {
      if (response?.data['data']['username'] != null) {
        if (response?.data['data']['username']['message'] ==
            'The username is invalid or already in use.') {
          message = 'نام کاربری نامعتبر یا قبلا ثبت شده است.';
        }
      }

      if (response?.data['data']['password'] != null) {
        if (response?.data['data']['password']['message'] ==
            'The length must be between 8 and 72.') {
          message = 'طول رمز عبور نباید کمتر از 8 کارکتر باشد.';
        }
      }

      if (response?.data['data']['passwordConfirm'] != null) {
        if (response?.data['data']['passwordConfirm']['message'] ==
            'Values don\'t match.') {
          message = 'رمز عبورها یکسان نیستند.';
        }
      }
    }
  }
}
