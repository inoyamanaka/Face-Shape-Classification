import 'package:face_shape/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'Tampilan_menu.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width; // lebar layar
    final double height = size.height; // tinggi layar

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        // color: Colors.amber,
        color: Color.fromARGB(255, 204, 218, 253),
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selamat Datang .....",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Face Shape Classification",
                      style: TextStyle(
                          fontSize: 23,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Tekan Mulai untuk melanjutkan!",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Image.asset("Assets/Images/splashscreen.jpg",
                width: 300, height: 350),
            SizedBox(
              height: 30,
            ),
            CustomButton(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.size,
                    alignment: Alignment.center,
                    duration: Duration(seconds: 1),
                    child: MainMenu(),
                  ),
                );
              },
              text: "Mulai",
              imageAsset: "Assets/Icons/play.png",
              width: 40,
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
