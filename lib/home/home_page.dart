import 'package:flutter/material.dart';
import 'package:flutter_ris/home/nav_bar.dart';
import 'package:flutter_ris/home/post_card.dart';
import 'package:flutter_ris/search/about_me.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> posts = [];
  int _selectedIndex = 0; // List to store posts

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.0.13:3003/api/posts'));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          posts = responseData.cast<Map<String, dynamic>>();
        });
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushNamed(context, '/chats');
    } else if (index == 1){
      Navigator.pushNamed(context, '/search');
    } else if (index == 2){
      _navigateToAboutPage();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
  
  Future<void> _navigateToAboutPage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? userId = prefs.getInt('userId');
  
  if (userId != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AboutPage(userId: userId),
      ),
    );
  }
}

  /*static List<Widget> _widgetOptions = <Widget>[
    UserListPage(), // Dummy widget to avoid null reference
    SearchPage(),
    ProfilePage(),
  ];
  */
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
      ),
      bottomNavigationBar: NavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
