import 'package:flutter_project_online_shop/models/product.dart';

abstract class ProductDetailPageCommentsEvent {}

class ProductDetailPageCommentsRequestCommentsEvent extends ProductDetailPageCommentsEvent {
  Product product;
  ProductDetailPageCommentsRequestCommentsEvent(this.product);
}

class ProductDetailPageCommentsRequestPostCommentEvent extends ProductDetailPageCommentsEvent {
  Product product;
  String commentText;
  ProductDetailPageCommentsRequestPostCommentEvent(
    this.product,
    this.commentText,
  );
}
