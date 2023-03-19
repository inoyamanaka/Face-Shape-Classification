import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const CustomBackButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: this.onTap,
            child: Image.asset(
              "Assets/Icons/back.png",
              width: 35,
              height: 35,
            ),
          ),
        ),
        SvgPicture.asset(
          "Assets/Svgs/hiasan_atas.svg",
        ),
      ],
    );
  }
}
