import 'package:flutter/material.dart';
import 'package:flutter_ris/search/about_me.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  Map<String, dynamic>? searchedUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter username',
                
                  icon: Icon(Icons.search),
                
              ),
            ),
            SizedBox(height: 20),
            searchedUser != null
                ? ListTile(
                    title: Text('Username: ${searchedUser!['username']}'),
                    subtitle: Text('Email: ${searchedUser!['email']}'),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
