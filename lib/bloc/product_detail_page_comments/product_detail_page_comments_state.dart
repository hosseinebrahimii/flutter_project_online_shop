import 'package:dartz/dartz.dart';
import 'package:flutter_project_online_shop/models/comment.dart';

abstract class ProductDetailPageCommentsState {}

class ProductDetailPageCommentsLoadingState extends ProductDetailPageCommentsState {}

class ProductDetailPageCommentsResponseCommentsState extends ProductDetailPageCommentsState {
  Either<String, List<Comment>> commentListEither;
  ProductDetailPageCommentsResponseCommentsState(this.commentListEither);
}

class ProductDetailPageCommentsResponsePostCommentState extends ProductDetailPageCommentsState {
  Either<String, String> postCommentEither;
  ProductDetailPageCommentsResponsePostCommentState(this.postCommentEither);
}
