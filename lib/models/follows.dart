import 'package:flutter_ris/models/user.dart';

class Follows {
  Users follower;
  Users following;
  DateTime dateFollowed;

  Follows({
    required this.follower,
    required this.following,
    required this.dateFollowed,
  });

  factory Follows.fromJson(Map<String, dynamic> json) {
    return Follows(
      follower: Users.fromJson(json['follower'] as Map<String, dynamic>),
      following: Users.fromJson(json['following'] as Map<String, dynamic>),
      dateFollowed: DateTime.parse(json['dateFollowed'] as String),
    );
  }
}