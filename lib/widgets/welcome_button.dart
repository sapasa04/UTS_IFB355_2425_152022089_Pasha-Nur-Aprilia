import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  final String buttonText;
  final Widget onTap; // Expecting a Widget to navigate to
  final Color color;
  final Color textColor;

  const WelcomeButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => onTap), // Navigate to the screen
        );
      },
      child: Text(
        buttonText,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
