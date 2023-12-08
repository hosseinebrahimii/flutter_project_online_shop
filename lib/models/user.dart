import 'package:flutter_project_online_shop/util/get_time_date.dart';

class User {
  String collectionId;
  String id;
  String name;
  String username;
  String avatar;
  String date;
  String time;

  User({
    required this.collectionId,
    required this.id,
    required this.name,
    required this.username,
    required this.avatar,
    required this.date,
    required this.time,
  });

  factory User.getFromJsonMapObject(Map<String, dynamic> jsonObject) {
    return User(
      collectionId: jsonObject['collectionId'],
      id: jsonObject['id'],
      name: jsonObject['name'],
      username: jsonObject['username'],
      avatar: jsonObject['avatar'],
      date: getDate(jsonObject['created']),
      time: getTime(jsonObject['created']),
    );
  }

  String getAvatarUrl() {
    return 'http://startflutter.ir/api/files/$collectionId/$id/$avatar';
  }

  Map<String, dynamic> convertToJsonMap() {
    return {
      'collectionId': collectionId,
      'id': id,
      'name': name,
      'username': username,
      'avatar': avatar,
      'date': date,
      'time': time,
    };
  }

  static User convertFromJsonToUser(Map<String, dynamic> json) {
    return User(
      collectionId: json['collectionId'],
      id: json['id'],
      name: json['name'],
      username: json['username'],
      avatar: json['avatar'],
      date: json['date'],
      time: json['time'],
    );
  }
}
