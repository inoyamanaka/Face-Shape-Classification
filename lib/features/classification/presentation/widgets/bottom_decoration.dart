import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomDecoration extends StatelessWidget {
  const BottomDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      child: SvgPicture.asset(
        "Assets/Svgs/hiasan_bawah.svg",
      ),
    );
  }
}
