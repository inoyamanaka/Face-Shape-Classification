import 'package:flutter/material.dart';
import 'features/classification/presentation/widgets/splash_page_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SplashWidget(height: size.height, width: size.width),
    );
  }
}
