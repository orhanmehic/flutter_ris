import 'package:flutter/material.dart';
import 'package:flutter_ris/home/post_card.dart';
import 'package:flutter_ris/models/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Posts> posts = []; // List to store posts

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.17:3003/api/posts'));

      if (response.statusCode == 201) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          posts =
              responseData.map((postJson) => Posts.fromJson(postJson)).toList();
        });
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return PostCard(post: post);
          },
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/newPost');
              },
              child: const Icon(Icons.add),
            ),
          ],
        ));
  }
}
