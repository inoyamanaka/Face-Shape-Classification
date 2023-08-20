import 'package:face_shape/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrainNextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const TrainNextButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 20.w,
        right: 20.w,
        bottom: 10.h,
        child: InkWell(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(seconds: 2),
            height: 55,
            width: 325,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors().primary,
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Image.asset(
                //   "Assets/Icons/next.png",
                //   width: 30,
                //   height: 30,
                // ),
                SizedBox(width: 5.w),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'Urbanist',
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 5.w),
              ],
            ),
          ),
        ));
  }
}
