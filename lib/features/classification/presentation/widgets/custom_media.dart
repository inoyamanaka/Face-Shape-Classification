import 'package:face_shape/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'path/to/camera_screen.dart';

class CostumMedia extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String imageAsset;

  const CostumMedia({
    Key? key,
    required this.onTap,
    required this.text,
    required this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 310.w,
        height: 150.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: Colors.black,
            width: 2.w,
          ),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                imageAsset,
                width: 310.w,
                fit: BoxFit.fill,
                color: Colors.black54,
                colorBlendMode: BlendMode.darken,
              ),
            ),
            Center(
              child: Container(
                width: 150.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: MyColors().secondary,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: Colors.black,
                    width: 3.w,
                  ),
                ),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
