import 'package:flutter_project_online_shop/models/product.dart';

abstract class ProductDetailPageCommentsEvent {}

class ProductDetailPageCommentsRequestEvent extends ProductDetailPageCommentsEvent {
  Product product;
  ProductDetailPageCommentsRequestEvent(this.product);
}
