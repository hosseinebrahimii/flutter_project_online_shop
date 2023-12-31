import 'package:dartz/dartz.dart';
import 'package:flutter_project_online_shop/data/datasource/authentication_datasource.dart';
import 'package:flutter_project_online_shop/di/di.dart';
import 'package:flutter_project_online_shop/util/api_exception.dart';
import 'package:flutter_project_online_shop/util/auth_manager.dart';

abstract class IAuthenticationRepository {
  Future<Either<String, String>> repositoryRegister(
    String username,
    String password,
    String passwordConfirm,
  );
  Future<Either<String, String>> repositoryLogin(
    String username,
    String password,
  );
}

class AuthenticationRepository extends IAuthenticationRepository {
  final IAuthenticatorDataSource _dataSource = locator.get();
  @override
  Future<Either<String, String>> repositoryRegister(
    String username,
    String password,
    String passwordConfirm,
  ) async {
    try {
      await _dataSource.dataSourceRegister(username, password, passwordConfirm);
      return right('data has registered succesfully');
    } on ApiException catch (ex) {
      return left(ex.message ?? 'error with no title');
    }
  }

  @override
  Future<Either<String, String>> repositoryLogin(
    String username,
    String password,
  ) async {
    try {
      await _dataSource.dataSourceLogin(username, password);
      if (AuthManager.readToken().isNotEmpty) {
        return right(AuthManager.readToken());
      } else {
        return left('no token is given');
      }
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }
}
