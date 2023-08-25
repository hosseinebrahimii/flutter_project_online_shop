import 'package:dio/dio.dart';
import 'package:flutter_project_online_shop/di/di.dart';
import 'package:flutter_project_online_shop/models/category.dart';
import 'package:flutter_project_online_shop/util/api_exception.dart';

abstract class ICategoryDataSource {
  Future<List<Category>> dataSourceGetCategoryList();
}

class CategoryDataSource extends ICategoryDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<Category>> dataSourceGetCategoryList() async {
    try {
      var response = await _dio.get('/collections/category/records');
      List<Category> categoryList =
          response.data['items'].map<Category>((jsonObject) => Category.getFromJsonMapObject(jsonObject)).toList();
      return categoryList;
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, 'DioError occured, ${ex.response!.data['message']}');
    } catch (ex) {
      throw ApiException(1, 'something unhandled happened, check category_datasource.dart');
    }
  }
}
