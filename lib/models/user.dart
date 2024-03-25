import 'package:flutter_ris/models/follows.dart';
import 'package:flutter_ris/models/post.dart';

class Users {
  final int id;
  final String username;
  final String email;
  final String password;
  final String? bio;
  final String photo;
  final bool private;
  final List<Posts> posts;
  final int postCount;
  final List<Follows> followers;
  final List<Follows> followings;

  Users({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    this.bio,
    required this.photo,
    required this.private,
    required this.posts,
    required this.postCount,
    required this.followers,
    required this.followings,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      bio: json['bio'] as String?,
      photo: json['photo'] as String,
      private: json['private'] as bool,
      posts: (json['posts'] as List<dynamic>)
          .map((postJson) => Posts.fromJson(postJson as Map<String, dynamic>))
          .toList(),
      postCount: json['postCount'] as int,
      followers: (json['followers'] as List<dynamic>)
          .map((followJson) => Follows.fromJson(followJson as Map<String, dynamic>))
          .toList(),
      followings: (json['followings'] as List<dynamic>)
          .map((followJson) => Follows.fromJson(followJson as Map<String, dynamic>))
          .toList(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'bio': bio,
      'photo': photo,
    };
  }
}

