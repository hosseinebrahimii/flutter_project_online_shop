import 'package:flutter_project_online_shop/models/category.dart';
import 'package:flutter_project_online_shop/models/enum_product_popularity.dart';
import 'package:flutter_project_online_shop/models/product_properties.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  String category;

  @HiveField(1)
  String collectionId;

  @HiveField(2)
  String id;

  @HiveField(3)
  String name;

  @HiveField(4)
  String popularity;

  @HiveField(5)
  String description;

  @HiveField(6)
  int price;

  @HiveField(7)
  int discountPrice;

  @HiveField(8)
  int quantity;

  @HiveField(9)
  String thumbnail;

  Product({
    required this.category,
    required this.collectionId,
    required this.id,
    required this.name,
    required this.popularity,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.quantity,
    required this.thumbnail,
  });
  factory Product.getFromJsonMapObject(Map<String, dynamic> jsonObject) {
    return Product(
      category: jsonObject['category'],
      collectionId: jsonObject['collectionId'],
      id: jsonObject['id'],
      name: jsonObject['name'],
      popularity: jsonObject['popularity'],
      description: jsonObject['description'],
      price: jsonObject['price'],
      discountPrice: jsonObject['discount_price'],
      quantity: jsonObject['quantity'],
      thumbnail: jsonObject['thumbnail'],
    );
  }
  String getImageUrl() {
    return 'http://startflutter.ir/api/files/$collectionId/$id/$thumbnail';
  }

  Popularity getPopularity() {
    if (popularity == 'Hotest') {
      return Popularity.hottest;
    } else if (popularity == 'Best Seller') {
      return Popularity.bestSeller;
    } else {
      return Popularity.none;
    }
  }

  Category findCategory(List<Category> categoryList) {
    return categoryList.where((element) => element.id == category).single;
  }

  List<ProductProperties> findProductProperties(List<ProductProperties> productPropertiesList) {
    return productPropertiesList.where((element) => element.productId == id).toList();
  }

  int getPriceWithDiscount() {
    return (price + discountPrice);
  }

  int getOffCount() {
    return (-discountPrice / price * 100).round();
  }
}
