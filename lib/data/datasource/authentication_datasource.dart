import 'package:dio/dio.dart';
import 'package:flutter_project_online_shop/models/user.dart';
import 'package:flutter_project_online_shop/util/api_exception.dart';
import 'package:flutter_project_online_shop/util/auth_manager.dart';
import 'package:flutter_project_online_shop/util/dio_provider.dart';

abstract class IAuthenticatorDataSource {
  Future<void> dataSourceRegister(
    String username,
    String password,
    String passwordConfirm,
  );
  Future<void> dataSourceLogin(
    String username,
    String password,
  );
}

class AuthenticationDataSource extends IAuthenticatorDataSource {
  final Dio _dio = DioProvider.createDioWithoutHeader();

  @override
  Future<void> dataSourceRegister(
    String username,
    String password,
    String passwordConfirm,
  ) async {
    try {
      await _dio.post(
        '/collections/users/records',
        data: {
          'username': username,
          'password': password,
          'passwordConfirm': passwordConfirm,
        },
      );
    } on DioException catch (ex) {
      throw ApiException(
        ex.response?.statusCode,
        ex.response?.data['message'],
      );
    } catch (ex) {
      throw ApiException(0, 'unkown error');
    }
  }

  @override
  Future<void> dataSourceLogin(String username, String password) async {
    try {
      var response = await _dio.post(
        '/collections/users/auth-with-password',
        data: {
          'identity': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        await AuthManager.saveUser(
          User.getFromJsonMapObject(response.data['record']),
        );
        AuthManager.saveToken(response.data['token']);
        return response.data['token'];
      }
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unkown error');
    }
  }
}
