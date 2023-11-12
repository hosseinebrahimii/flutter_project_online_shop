import 'package:flutter_project_online_shop/models/user.dart';
import 'package:flutter_project_online_shop/util/get_time_date.dart';

class Comment {
  String collectionId;
  String id;
  String productId;
  String userId;
  String date;
  String time;
  String text;
  User user;

  Comment({
    required this.collectionId,
    required this.id,
    required this.productId,
    required this.userId,
    required this.date,
    required this.time,
    required this.text,
    required this.user,
  });

  factory Comment.getFromJsonMapObject(Map<String, dynamic> jsonObject) {
    return Comment(
      collectionId: jsonObject['collectionId'],
      id: jsonObject['id'],
      productId: jsonObject['product_id'],
      userId: jsonObject['user_id'],
      date: getDate(jsonObject['created']),
      time: getTime(jsonObject['created']),
      text: jsonObject['text'],
      user: User.getFromJsonMapObject(jsonObject['expand']['user_id']),
    );
  }
}
