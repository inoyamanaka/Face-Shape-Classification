// ignore_for_file: strict_raw_type

import 'package:face_shape/core/router/routes.dart';
import 'package:face_shape/features/classification/presentation/pages/main_menu_page.dart';
import 'package:face_shape/features/classification/presentation/pages/user_menu_camera.dart';
import 'package:face_shape/features/classification/presentation/pages/user_menu_guide.dart';
import 'package:face_shape/features/classification/presentation/pages/user_menu_page.dart';
import 'package:face_shape/features/classification/presentation/pages/user_menu_result.dart';
import 'package:face_shape/features/training/presentation/pages/dev_menu_page.dart';
import 'package:face_shape/splash_page.dart';
import 'package:get/get.dart';

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.menu,
      page: () => const MenuMode(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.userMenu,
      page: () => const UserMenuPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.userGuide,
      page: () => const PanduanScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.userCamera,
      page: () => const CameraScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.userResult,
      page: () => const ReportScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.trainMenu,
      page: () => const DevMenuPage(),
      transition: Transition.cupertino,
    ),
  ];
}
