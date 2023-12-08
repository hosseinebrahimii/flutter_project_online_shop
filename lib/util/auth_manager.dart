import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project_online_shop/di/di.dart';
import 'package:flutter_project_online_shop/models/user.dart';
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

  static String readToken() {
    return _sharedPref.getString('token') ?? '';
  }

  static void logOut() {
    _sharedPref.clear();
    authChangeNotifier.value = null;
  }

  static bool isLoggedIn() {
    // return AuthManager.authChangeNotifier.value.isNotEmpty;
    if (AuthManager.authChangeNotifier.value == null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<void> saveUser(User? user) async {
    //shared preferences can't save objects so we should use basic types like string
    //we should use jsonEncode to parse userJsonObject to string.
    if (user != null) {
      await _sharedPref.setString(
        'user',
        jsonEncode(user.convertToJsonMap()),
      );
    } else {
      await _sharedPref.setString(
        'user',
        '',
      );
    }
  }

  static User? readUser() {
    //we saved user as a string, so in order to load user, we should get the string
    //then decode it to a userJson and then parse it to a User model.
    String userString = _sharedPref.getString('user')!;
    if (userString != '') {
      Map<String, dynamic> userJson = jsonDecode(userString);
      User user = User.convertFromJsonToUser(userJson);
      return user;
    } else {
      return null;
    }
  }
}
