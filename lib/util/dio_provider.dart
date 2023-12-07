import 'package:dio/dio.dart';
import 'package:flutter_project_online_shop/util/auth_manager.dart';

class DioProvider {
  static Dio createDioWithHeader() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'http://startflutter.ir/api/',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthManager.readToken()}',
        },
      ),
    );
    return dio;
  }

  static Dio createDioWithoutHeader() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'http://startflutter.ir/api/',
      ),
    );
    return dio;
  }
}
