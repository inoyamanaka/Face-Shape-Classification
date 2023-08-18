import 'package:flutter/material.dart';

class MyColors {
  final Color primary = const Color.fromARGB(255, 19, 21, 34);
  final Color secondary = const Color.fromARGB(255, 80, 101, 252);
  final Color third = const Color.fromARGB(255, 217, 217, 217);
}

class MyFonts {
  final TextStyle primary = const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w500);

  final TextStyle primary300 = const TextStyle(
      fontSize: 16, fontFamily: 'Urbanist', fontWeight: FontWeight.w300);

  final TextStyle secondary = const TextStyle(
      color: Color.fromARGB(255, 80, 101, 252),
      fontSize: 16,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w700);

  final TextStyle third = const TextStyle(
      fontSize: 28, fontFamily: 'Urbanist', fontWeight: FontWeight.w700);
}
