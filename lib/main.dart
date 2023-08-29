import 'package:face_shape/core/di/injection.dart';
import 'package:face_shape/core/router/navigation.dart';
import 'package:face_shape/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// GetIt sl = GetIt.instance;

void main() {
  inject();
  runApp(const MyApp());
}

void inject() async {
  final injection = Injection();
  await injection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.trainResult,
        getPages: Nav.routes);
  }
}
