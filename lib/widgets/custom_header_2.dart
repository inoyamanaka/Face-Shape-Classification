import 'package:flutter/material.dart';

class CustomHeader2 extends StatelessWidget {
  final String isi;
  const CustomHeader2({
    Key? key,
    required this.isi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color.fromARGB(255, 19, 21, 34),
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            this.isi,
            style: TextStyle(
                color: Color.fromARGB(255, 19, 21, 34),
                fontSize: 16,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
