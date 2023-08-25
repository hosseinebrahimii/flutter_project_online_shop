import 'package:flutter/animation.dart';

class Category {
  String collectionId;
  String id;
  String title;
  String color;
  String icon;
  String thumbnail;

  Category({
    required this.collectionId,
    required this.id,
    required this.title,
    required this.color,
    required this.icon,
    required this.thumbnail,
  });

  factory Category.getFromJsonMapObject(Map<String, dynamic> jsonObject) {
    return Category(
      collectionId: jsonObject['collectionId']!,
      id: jsonObject['id']!,
      title: jsonObject['title']!,
      color: jsonObject['color']!,
      icon: jsonObject['icon']!,
      thumbnail: jsonObject['thumbnail']!,
    );
  }

  String getImageUrl() {
    return 'http://startflutter.ir/api/files/$collectionId/$id/$thumbnail';
  }

  String getIcon() {
    return 'http://startflutter.ir/api/files/$collectionId/$id/$icon';
  }

  Color getColor() {
    int colorHexCode = int.parse(color, radix: 16);
    return Color(0xff000000 + colorHexCode);
  }
}
