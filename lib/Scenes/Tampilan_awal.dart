import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:face_shape/Scenes/Tampilan_mode.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width; // lebar layar
    final double height = size.height; // tinggi layar

    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: AnimatedSplashScreen(
          duration: 5000,
          splash: Container(
            child: Stack(children: [
              Image.asset(
                "Assets/Images/Tampilan awal.png",
                height: height,
                width: width,
                fit: BoxFit.fill,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Image.asset(
                    "Assets/Images/icon_splash.gif",
                    width: 170,
                    height: 170,

                    // fit: BoxFit.fill,
                  ),
                ),
              ),
            ]),
          ),
          nextScreen: MenuMode(),
          splashTransition: SplashTransition.fadeTransition,
          splashIconSize: height,
        ),
      ),
    );
  }
}
