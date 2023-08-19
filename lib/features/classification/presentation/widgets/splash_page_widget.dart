import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:face_shape/features/classification/presentation/pages/main_menu_page.dart';
import 'package:flutter/material.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                padding: const EdgeInsets.only(bottom: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "Assets/Images/icon_splash.gif",
                    width: 170,
                    height: 170,
                  ),
                ),
              ),
            ),
          ]),
        ),
        nextScreen: const MenuMode(),
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: height,
      ),
    );
  }
}
