import 'package:flutter/material.dart';
import 'package:flutter_ris/authentication/login_page.dart';
import 'package:flutter_ris/authentication/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'IBMPlexMono'),
      initialRoute: determineInitialRoute(),
      routes: {
        '/login': (context) => LoginPage(),
        //'/home': (context) => HomePage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }

}

String determineInitialRoute(){
    return '/login';
}

