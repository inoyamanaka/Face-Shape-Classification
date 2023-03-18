import 'package:flutter/material.dart';
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
      onTap: this.onTap,
      child: Container(
        width: 310,
        height: 165,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                this.imageAsset,
                width: 310,
                fit: BoxFit.fill,
                color: Colors.black54,
                colorBlendMode: BlendMode.darken,
              ),
            ),
            Center(
              child: Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 80, 101, 252),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: Colors.black,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    this.text,
                    style: TextStyle(
                      fontSize: 16,
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
