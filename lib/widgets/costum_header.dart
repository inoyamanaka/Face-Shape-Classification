import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String isi;
  const CustomHeader({
    Key? key,
    required this.isi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: 250,
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 19, 21, 34),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Center(
        child: Text(
          this.isi,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
