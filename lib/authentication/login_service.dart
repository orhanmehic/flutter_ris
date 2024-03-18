import 'dart:convert'; // Required for JSON encoding/decoding
import 'package:http/http.dart' as http; // HTTP client for making requests

// Define the base URL of your API
const String url = 'http://192.168.0.17:3003/api/user/authenticate';

// Define the login function
Future<bool> login(String username, String password) async {

  try {
    // Make a POST request to the login endpoint
    final response = await http.post(
      Uri.parse(url),
      body: {
        'username': username,
        'password': password,
      },
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Parse the response JSON
      Map<String, dynamic> responseData = json.decode(response.body);

      // Check if the login was successful
      bool loggedIn = responseData['success'] ?? false;

      return loggedIn;
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
