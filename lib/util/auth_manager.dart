import 'package:flutter/material.dart';
import 'package:flutter_project_online_shop/di/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  //properties:

  static final ValueNotifier authChangeNotifier = ValueNotifier(null);
  static final SharedPreferences _sharedPref = locator.get();

  //methods:

  static void saveToken(String token) {
    _sharedPref.setString('token', token);
    authChangeNotifier.value = token;
  }

  static String readAuth() {
    return _sharedPref.getString('token') ?? '';
  }

  static void logOut() {
    _sharedPref.clear();
    authChangeNotifier.value = null;
  }

  static bool isLoggedIn() {
    return AuthManager.authChangeNotifier.value.isNotEmpty;
  }
}
