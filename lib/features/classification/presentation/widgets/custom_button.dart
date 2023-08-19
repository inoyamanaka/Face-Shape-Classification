import 'package:face_shape/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String imageAsset;
  final double width, height;

  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.imageAsset,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyColors color = MyColors();
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55.h,
        width: 325.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color.secondary,
          border: Border.all(
            color: Colors.black,
            width: 2.w,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 10.w),
            Image.asset(
              imageAsset,
              width: width * 0.8,
              height: height * 0.7,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 20.sp,
                fontFamily: 'Urbanist',
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 50.w)
          ],
        ),
      ),
    );
  }
}
