import 'package:face_shape/config/config.dart';
import 'package:face_shape/core/models/main_menu_att.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ModeButton extends StatelessWidget {
  const ModeButton({
    super.key,
    required int currentIndex,
  }) : _currentIndex = currentIndex;

  final int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: 75.h,
      width: 250.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: _currentIndex == 1 ? MyColors().fourth : MyColors().primary,
        border: Border.all(
          color: Colors.black,
          width: 2.w,
        ),
      ),
      child: Text(
        MainMenuAtt.mode[_currentIndex],
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.sp,
          fontFamily: 'Urbanist',
          color: _currentIndex == 1 ? MyColors().primary : MyColors().fourth,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
