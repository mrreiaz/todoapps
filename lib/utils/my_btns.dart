import 'package:flutter/material.dart';

class MyBtns extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyBtns({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: text == 'Save' ? Theme.of(context).primaryColor : Colors.red,
      child: Text(text),
    );
  }
}
