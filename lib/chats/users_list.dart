
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'chat_page.dart'; // Import the ChatPage widget

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<Map<String, dynamic>> users = [];
  int? senderId;

  @override
  void initState() {
  super.initState();
  _loadSenderId().then((_) {
    fetchUsers();
  });
}

  Future<void> _loadSenderId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    senderId = prefs.getInt('userId');
  }

  Future<void> fetchUsers() async {
    print('dal je ovo $senderId');
    try {
      final response = await http.get(
        Uri.parse('http://192.168.0.13:3003/api/chats/users?userId=$senderId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          users = responseData.cast<Map<String, dynamic>>();
          print(users);
        });
      } else {
        throw Exception('Failed to fetch users');
      }
    } catch (e) {
      print('Error fetching users: $e');
    }
  }
  

  void openChat(Map<String, dynamic> user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(user: user, senderId: senderId,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(user['username'][0]), // Updated to match 'username' field
            ),
            title: Text(user['username']), // Updated to match 'username' field
            subtitle: Text(user['email']), // Added email for additional user info
            onTap: () => openChat(user),
          );
        },
      ),
    );
  }
}