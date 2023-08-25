import 'package:flutter/material.dart';

class ProductVariants {
  String collectionId;
  String id;
  String name;
  String productId;
  String typeId;
  String value;
  int priceChange;

  ProductVariants({
    required this.collectionId,
    required this.id,
    required this.name,
    required this.productId,
    required this.typeId,
    required this.value,
    required this.priceChange,
  });

  factory ProductVariants.getFromJsonMapObject(
      Map<String, dynamic> jsonObject) {
    return ProductVariants(
      collectionId: jsonObject['collectionId'],
      id: jsonObject['id'],
      name: jsonObject['name'],
      productId: jsonObject['product_id'],
      typeId: jsonObject['type_id'],
      value: jsonObject['value'],
      priceChange: jsonObject['price_change'],
    );
  }

  getVariantStatus() {
    if (typeId == 'wzp3vjuzqzyk6bi') {
      int colorHexCode = int.parse(value, radix: 16);
      return Color(0xff000000 + colorHexCode);
    }
    return value;
  }
}
