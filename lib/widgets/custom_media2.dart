import 'package:flutter/material.dart';

class CustomButton2 extends StatelessWidget {
  final String isi;
  final VoidCallback onTap;

  const CustomButton2({
    Key? key,
    required this.isi,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: InkWell(
        onTap: this.onTap,
        child: AnimatedContainer(
          duration: Duration(seconds: 2),
          height: 55,
          width: 325,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 19, 21, 34),
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Image.asset(
              //   "Assets/Icons/next.png",
              //   width: 30,
              //   height: 30,
              // ),
              SizedBox(
                width: 5,
              ),
              Text(
                this.isi,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Urbanist',
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
