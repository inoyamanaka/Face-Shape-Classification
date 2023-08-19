import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleApp extends StatelessWidget {
  final String textTitle;
  const TitleApp({super.key, required this.textTitle});

  @override
  Widget build(BuildContext context) {
    return Text(
      textTitle,
      style: TextStyle(
          fontSize: 28.sp, fontFamily: 'Urbanist', fontWeight: FontWeight.w700),
    );
  }
}
