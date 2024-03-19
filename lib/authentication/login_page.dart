import 'package:flutter/material.dart';
import 'package:flutter_ris/authentication/change_button.dart';
import 'package:flutter_ris/authentication/submit_button.dart';
import 'input_field.dart';
import 'login_service.dart' as login_service;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  Future<void> login() async {
    String username = usernameController.text;
    String password = passwordController.text;
    bool loggedIn = await login_service.login(username, password);

    if (loggedIn) {
      _showSnackBar('Login successful');
    } else {
      _showSnackBar('Login failed. Please try again.');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2), // Duration for which the snackbar is displayed
    ));
  }

  @override
  Widget build(BuildContext context) {
    AssetImage logo = const AssetImage('assets/logonn.png');
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 184, 183, 183),
        centerTitle: true,
        
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'IBMPlexMono',
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 184, 183, 183),
      body:SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logonn.png',
                height: 300,
                width: 300,
              ),
              Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    InputField(
                      labelText: 'Username',
                      controller: usernameController,
                    ),
                    InputField(
                      labelText: 'Password',
                      obscureText: true,
                      controller: passwordController,
                    ),
                    SizedBox(height: 20),
                    SubmitButton(onPressed: login, labelText: 'Login'),
                    SizedBox(height: 15),
                    ChangeButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      }, 
                      labelText: 'Create an account'
                    )
                  ]
                )
              )
            ],
          ),
        ),
      )
    );
  }
}
