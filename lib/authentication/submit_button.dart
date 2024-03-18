import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String labelText;

  const SubmitButton({super.key, 
    required this.onPressed,
    required this.labelText
    });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 27, 179, 16),
        //fixedSize: Size(130, 45),
        minimumSize: Size(150, 45),
        shadowColor: Colors.green,
      ),
      onPressed: onPressed,
      child: Text(
        labelText,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w900,
          fontSize: 18,
        ),
      ),
    );
  }
}
