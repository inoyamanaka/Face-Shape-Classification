import 'package:flutter/material.dart';

class TitleApp extends StatelessWidget {
  final String textTitle;
  const TitleApp({super.key, required this.textTitle});

  @override
  Widget build(BuildContext context) {
    return Text(
      textTitle,
      style: const TextStyle(
          fontSize: 28, fontFamily: 'Urbanist', fontWeight: FontWeight.w700),
    );
  }
}
