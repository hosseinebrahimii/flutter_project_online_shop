import 'package:dio/dio.dart';
import 'package:flutter_project_online_shop/di/di.dart';
import 'package:flutter_project_online_shop/models/comment.dart';
import 'package:flutter_project_online_shop/models/product.dart';
import 'package:flutter_project_online_shop/util/api_exception.dart';

abstract class ICommentDataSource {
  Future<List<Comment>> dataSourceGetCommentList(Product product);
}

class CommentDataSource extends ICommentDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<Comment>> dataSourceGetCommentList(Product product) async {
    try {
      var qparams = {'filter': 'product_id = "${product.id}" && user_id != "" && text != ""', 'expand': 'user_id'};
      var response = await _dio.get(
        '/collections/comment/records',
        queryParameters: qparams,
      );
      List<Comment> commentList =
          response.data['items'].map<Comment>((jsonObject) => Comment.getFromJsonMapObject(jsonObject)).toList();
      return commentList;
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode, 'DioError occured, ${ex.response!.data['message']}');
    } catch (ex) {
      throw ApiException(1, 'something unhandled happened, check category_datasource.dart');
    }
  }
}
