import 'package:apple_shop/di/api_di.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final SharedPreferences _sharedPreferences = serviceLocator.get();

  static final ValueNotifier<String?> valueNotifier = ValueNotifier(null);

  static void saveToken(String token) async {
    _sharedPreferences.setString('access_token', token);
    valueNotifier.value = token;
  }

  static String readToken() {
    return _sharedPreferences.getString('access_token') ?? '';
  }

  static void saveUserId(String userId) async {
    _sharedPreferences.setString('user_id', userId);
  }

  static String readUserId() {
    return _sharedPreferences.getString('user_id') ?? '';
  }

  static void logOut() {
    _sharedPreferences.clear();
    valueNotifier.value = null;
  }

  static bool isUserLoggedin() {
    return readToken().isNotEmpty;
  }
}
