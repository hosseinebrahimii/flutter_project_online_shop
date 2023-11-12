import 'package:dartz/dartz.dart';
import 'package:flutter_project_online_shop/models/comment.dart';

abstract class ProductDetailPageCommentsState {}

class ProductDetailPageCommentsLoadingState extends ProductDetailPageCommentsState {}

class ProductDetailPageCommentsResponseState extends ProductDetailPageCommentsState {
  Either<String, List<Comment>> commentListEither;
  ProductDetailPageCommentsResponseState(this.commentListEither);
}
