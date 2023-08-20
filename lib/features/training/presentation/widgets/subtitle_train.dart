import 'package:face_shape/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubTitle extends StatelessWidget {
  final String text;
  const SubTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Text(
        text,
        style: TextStyle(
            color: MyColors().primary,
            fontSize: 16.sp,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
