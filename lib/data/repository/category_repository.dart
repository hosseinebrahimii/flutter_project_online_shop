import 'package:dartz/dartz.dart';
import 'package:flutter_project_online_shop/data/datasource/category_datasource.dart';
import 'package:flutter_project_online_shop/di/di.dart';
import 'package:flutter_project_online_shop/models/category.dart';
import 'package:flutter_project_online_shop/util/api_exception.dart';

abstract class ICategoryRepository {
  Future<Either<String, List<Category>>> repositoryGetCategoryList();
}

class CategoryRepository extends ICategoryRepository {
  final ICategoryDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<Category>>> repositoryGetCategoryList() async {
    try {
      var response = await _dataSource.dataSourceGetCategoryList();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    } catch (ex) {
      return left('Error happened in category_repository.dart! please handle it');
    }
  }
}
