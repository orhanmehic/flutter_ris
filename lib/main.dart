import 'package:flutter/material.dart';
import 'package:flutter_ris/authentication/login_page.dart';
import 'package:flutter_ris/authentication/register_page.dart';
import 'package:flutter_ris/chats/users_list.dart';
import 'package:flutter_ris/firebase_options.dart';
import 'package:flutter_ris/home/home_page.dart';
import 'package:flutter_ris/home/new_post.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'IBMPlexMono'),
      initialRoute: determineInitialRoute(prefs),
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/register': (context) => RegisterPage(),
        '/newPost': (context) => NewPost(),
        '/chats': (context) => UserListPage(),
      },
    );
  }

}

String determineInitialRoute(SharedPreferences prefs){
  final bool isLoggedIn = prefs.containsKey('userId'); // Check if user data exists
  // Return appropriate route
  return isLoggedIn ? '/home' : '/login'; 
}

