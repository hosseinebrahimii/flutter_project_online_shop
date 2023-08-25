import 'package:flutter_project_online_shop/models/enum_product_variant_type.dart';

class ProductVariantType {
  String collectionId;
  String id;
  String name;
  String title;
  String type;

  ProductVariantType({
    required this.collectionId,
    required this.id,
    required this.name,
    required this.title,
    required this.type,
  });
  factory ProductVariantType.getFromJsonMapObject(Map<String, dynamic> jsonObject) {
    return ProductVariantType(
      collectionId: jsonObject['collectionId'],
      id: jsonObject['id'],
      name: jsonObject['name'],
      title: jsonObject['title'],
      type: jsonObject['type'],
    );
  }

  VariantType getVariantType() {
    if (type == 'Color') {
      return VariantType.color;
    }
    if (type == 'Storage') {
      return VariantType.storage;
    }
    return VariantType.voltage;
  }
}
