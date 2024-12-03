import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final BuildContext context;

  CustomBackButton({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: Colors.black, // Set the icon color
        size: 25,
      ),
    );
  }
}
