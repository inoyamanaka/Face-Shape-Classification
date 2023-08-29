import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardImage extends StatelessWidget {
  const CardImage({
    super.key,
    required this.title,
    required this.deskripsi,
    required this.image,
    required this.tahap,
  });

  final String title;
  final String deskripsi;
  final String image;
  final String tahap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 230.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color.fromARGB(255, 19, 21, 34),
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    color: const Color.fromARGB(255, 19, 21, 34),
                    fontSize: 16.sp,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          height: 245.h,
          width: 300.w,
          decoration: BoxDecoration(
              border: Border.all(width: 1),
              color: const Color.fromARGB(255, 217, 217, 217),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 140.h,
              width: 280.w,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              height: 80.h,
              width: 280.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  deskripsi,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: const Color.fromARGB(255, 19, 21, 34),
                      fontSize: 15.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(height: 5.h),
          ]),
        ),
      ],
    );
  }
}
