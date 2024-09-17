import 'package:flutter/material.dart';
import 'change_button.dart';
import 'submit_button.dart';
import 'input_field.dart';
import 'register_service.dart' as register_service;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _showSnackBar(String message) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2),
        ));
  }
  
  
  
  Future<void> register() async {
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    
    bool registered = await register_service.register(username, email, password);
    
    if (registered) {
        _showSnackBar('Registration successful');
    } else {
        _showSnackBar('Registration failed. Please try again.');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 184, 183, 183),
        centerTitle: true,
        title: const Text('Register',
        style: TextStyle(
          fontSize: 30

        ),),
      ),
      backgroundColor: const Color.fromARGB(255, 184, 183, 183),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logonn.png', // Replace with your image path
              height: 300,
              width: 300,
              //color: Colors.transparent,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputField(
                  labelText: 'Username',
                  controller: usernameController,
                ),
                InputField(
                  labelText: 'Email',
                  controller: emailController,
                ),
                InputField(
                  labelText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                ),
                SizedBox(height: 20),
                SubmitButton(onPressed: register, labelText: 'Register'),
                SizedBox(height: 15),
                ChangeButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  labelText: 'Back to Login',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
