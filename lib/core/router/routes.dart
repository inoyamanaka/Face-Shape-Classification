class Routes {
  static Future<String> get initialRoute async {
    return menu;
  }

  static const menu = '/menu';
  static const userMenu = '/user_menu';
  static const userGuide = '/user_guide';
  static const userCamera = '/user_camera';
  static const userResult = '/user_result';

  static const trainMenu = '/train_menu';
}
