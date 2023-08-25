import 'package:flutter/material.dart';
import 'package:flutter_project_online_shop/models/product.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'purchased_product.g.dart';

@HiveType(typeId: 1)
class PurchasedProduct extends HiveObject {
  @HiveField(0)
  Product product;

  @HiveField(1)
  Color productColor;

  @HiveField(2)
  String productColorName;

  @HiveField(3)
  String productStorage;

  @HiveField(4)
  int initialPrice;

  @HiveField(5)
  int finalPrice;

  PurchasedProduct({
    required this.product,
    required this.productColor,
    required this.productColorName,
    required this.productStorage,
    required this.initialPrice,
    required this.finalPrice,
  });
}
