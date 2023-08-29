import 'package:flutter/material.dart';

class CustomList2 extends StatelessWidget {
  final String preprocessing;
  const CustomList2({
    Key? key,
    required this.preprocessing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: "• ",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: preprocessing,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
