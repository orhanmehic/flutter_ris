import 'package:flutter_ris/models/user.dart';

class Posts {
  String id;
  Users user;
  String imageUrl;
  String? caption;
  int likes;
  DateTime createdAt;

  Posts({
    required this.id,
    required this.user,
    required this.imageUrl,
    required this.caption,
    required this.likes,
    required this.createdAt,
  });

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      id: json['id'] as String,
      user: Users.fromJson(json['user'] as Map<String, dynamic>),
      imageUrl: json['imageUrl'] as String,
      caption: json['caption'] as String?,
      likes: json['likes'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}