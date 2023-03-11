import 'package:face_shape/Scenes/Tampilan_hasil.dart';
import 'package:face_shape/Scenes/Tampilan_menu.dart';
import 'package:face_shape/Scenes/Tampilan_panduan.dart';
import 'package:flutter/material.dart';
import 'Scenes/Tampilan_awal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen());
  }
}
