import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AboutPage extends StatefulWidget {
  final int userId;

  AboutPage({required this.userId});

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Map<String, dynamic>? userInfo;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.0.13:3003/api/user/${widget.userId}'));

      if (response.statusCode == 200) {
        setState(() {
          userInfo = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to fetch user info');
      }
    } catch (e) {
      print('Error fetching user info: $e');
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('About User'),
      backgroundColor: Colors.blueAccent,
    ),
    body: userInfo == null
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile section with avatar
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(Icons.person, size: 50, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userInfo!['username'] ?? 'Unknown',
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            userInfo!['email'] ?? 'No Email Available',
                            style: const TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Information card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'User Information',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Divider(thickness: 1.5),
                          const SizedBox(height: 10),
                          _buildInfoRow(Icons.person, 'Username', userInfo!['username']),
                          const SizedBox(height: 10),
                          _buildInfoRow(Icons.email, 'Email', userInfo!['email']),
                          // Add more user details here if necessary
                        ],
                      ),
                    ),
                  ),
                  
                  // More space for future buttons or additional user information
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Add any action for the button (e.g. edit profile)
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Profile'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent, // Use backgroundColor instead of primary
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
  );
}

Widget _buildInfoRow(IconData icon, String label, String? value) {
  return Row(
    children: [
      Icon(icon, color: Colors.blueAccent),
      const SizedBox(width: 10),
      Text(
        '$label: ',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Expanded(
        child: Text(
          value ?? 'Not available',
          style: const TextStyle(fontSize: 16),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
}
