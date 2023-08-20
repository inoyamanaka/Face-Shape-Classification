import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopMenuTrain extends StatelessWidget {
  final VoidCallback ontap;
  const TopMenuTrain({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                ontap;
              },
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
      ),
    );
  }
}
