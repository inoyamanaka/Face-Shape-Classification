import 'package:flutter/material.dart';

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
    return InkWell(
      onTap: this.onTap,
      child: Container(
        height: 75,
        width: 325,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          color: Color.fromARGB(255, 80, 101, 252),
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 10,
            ),
            Image.asset(
              this.imageAsset,
              width: width,
              height: height,
            ),
            Text(
              this.text,
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Urbanist',
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              width: 50,
            )
          ],
        ),
      ),
    );
  }
}
