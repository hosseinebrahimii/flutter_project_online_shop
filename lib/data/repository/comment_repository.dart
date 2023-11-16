import 'package:dartz/dartz.dart';
import 'package:flutter_project_online_shop/data/datasource/comment_datasource.dart';
import 'package:flutter_project_online_shop/di/di.dart';
import 'package:flutter_project_online_shop/models/comment.dart';
import 'package:flutter_project_online_shop/models/product.dart';
import 'package:flutter_project_online_shop/util/api_exception.dart';

abstract class ICommentRepository {
  Future<Either<String, List<Comment>>> repositoryGetCommentList(Product product);
  Future<Either<String, String>> repositoryPostComment(
    Product product,
    String commentText,
  );
}

class CommentRepository extends ICommentRepository {
  final ICommentDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<Comment>>> repositoryGetCommentList(Product product) async {
    try {
      var response = await _dataSource.dataSourceGetCommentList(product);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    } catch (ex) {
      return left('خطای نامشخص هنگام دریافت نظرات');
    }
  }

  @override
  Future<Either<String, String>> repositoryPostComment(
    Product product,
    String commentText,
  ) async {
    try {
      await _dataSource.dataSourcePostComment(product, commentText);
      return right('دیدگاه شما ثبت گردید');
    } on ApiException catch (ex) {
      return left(ex.message!);
    } catch (ex) {
      return left('خطای نامشخص هنگام ثبت دیدگاه');
    }
  }
}
