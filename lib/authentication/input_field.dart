import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget{

  final String labelText;
  final TextEditingController controller;
  final bool obscureText; 

  const InputField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.obscureText = false
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              ),
            borderRadius: BorderRadius.circular(25),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 19
            
          ),
          //focusColor: Colors.black,
          
          hoverColor: const Color.fromARGB(0, 0, 0, 0),
          filled: true,
          fillColor: Color.fromARGB(0, 46, 166, 222),
        ),
      ),
    );
  }
}