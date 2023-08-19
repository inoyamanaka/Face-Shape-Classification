import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyColors {
  final Color primary = const Color.fromARGB(255, 19, 21, 34);
  final Color secondary = const Color.fromARGB(255, 80, 101, 252);
  final Color third = const Color.fromARGB(255, 217, 217, 217);
  final Color fourth = const Color.fromARGB(255, 212, 245, 252);
}

class MyFonts {
  final TextStyle primary = TextStyle(
      color: Colors.black,
      fontSize: 16.sp,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w500);

  final TextStyle primary300 = TextStyle(
      fontSize: 16.sp, fontFamily: 'Urbanist', fontWeight: FontWeight.w300);

  final TextStyle secondary = TextStyle(
      color: const Color.fromARGB(255, 80, 101, 252),
      fontSize: 16.sp,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w700);

  final TextStyle third = TextStyle(
      fontSize: 28.sp, fontFamily: 'Urbanist', fontWeight: FontWeight.w700);
}
