class Routes {
  static Future<String> get initialRoute async {
    return splash;
  }

  static const splash = '/splash_screen';
  static const menu = '/menu';

  static const userMenu = '/user_menu';
  static const userGuide = '/user_guide';
  static const userCamera = '/user_camera';
  static const userResult = '/user_result';

  static const trainMenu = '/train_menu';
  static const trainPreprocess = '/train_preprocess';
  static const trainVerif = '/train_verification';
  static const trainResult = '/train_result';
}
