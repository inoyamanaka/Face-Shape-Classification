import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardMode extends StatelessWidget {
  final String image;
  const CardMode({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        border: Border.all(
          color: Colors.black, // warna border
          width: 2, // ketebalan border
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40.0),
        child: Image.asset(
          image,
          width: 250.w,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
