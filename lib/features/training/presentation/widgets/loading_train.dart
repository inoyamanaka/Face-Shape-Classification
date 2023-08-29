import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingOverlayTrain extends StatelessWidget {
  final String text;

  const LoadingOverlayTrain({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: const ModalBarrier(
            dismissible: false,
            color: Colors.transparent,
          ),
        ),
      Center(
        child: Container(
          width: 250,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SpinKitSquareCircle(
                color: Color.fromARGB(255, 80, 101, 252),
                size: 50.0,
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: 220.w,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}
