import 'dart:convert'; // Required for JSON encoding/decoding
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // HTTP client for making requests

// Define the base URL of your API
const String url = 'http://192.168.0.13:3003/api/user/authenticate';

Future<void> saveUserData(int userId, String username) async {

  // Get an instance of SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Save the user JSON string to SharedPreferences
  await prefs.setString('username', username);
  await prefs.setInt('userId', userId);

}

// Function to clear user login preferences
Future<void> clearUserPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('username');
  await prefs.remove('isLoggedIn');
}

// Define the login function
Future<bool> login(String username, String password) async {
  try {
    // Make a POST request to the login endpoint
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 201) {
      print("loginovano");
      print(response.body);
      // Parse the response JSON and create a User object
      Map<String, dynamic> responseData = json.decode(response.body);

      int userId = responseData['id'] as int;
      String username = responseData['username'] as String;

      print('${userId}  ${username}');

      // Save the user object to shared preferences
      await saveUserData(userId, username);

      return true;
    } else {
      // If the request was not successful, throw an error
      throw Exception('Failed to login. Status Code: ${response.statusCode}');
    }
  } catch (e) {
    // Catch any errors that occur during the request
    print('Error during login: $e');
    return false; // Return false to indicate login failure
  }

}


