import 'dart:convert';
import 'package:http/http.dart' as http;

const String url = 'http://192.168.0.17:3003/api/user/register';

Future<bool> register(String username, String email, String password) async {

  

  try {
    final response = await http.post(
    Uri.parse(url),
    headers: {
    'Content-Type': 'application/json',
    },
    body: json.encode({
      'username': username,
      'email': email,
      'password': password,
    }),
    );

    if (response.statusCode == 201) {
      Map<String, dynamic> responseData = json.decode(response.body);
      //bool registered = responseData['success'] ?? false;
      //return registered;
      return true; 
    } else {
      throw Exception('Failed to register. Status Code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during registration: $e');
    return false;
  }
}

