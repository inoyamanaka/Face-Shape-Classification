import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitlePage extends StatelessWidget {
  final String text;
  const TitlePage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 19, 21, 34),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
