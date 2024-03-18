import 'package:flutter/material.dart';

class ChangeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String labelText;

  const ChangeButton({
    required this.onPressed,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        labelText,
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 15, 87, 147),
        ),
      ),
    );
  }
}
