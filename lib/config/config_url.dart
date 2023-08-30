// ignore_for_file: constant_identifier_names

class ApiUrl {
  // static const Url = "http://192.168.100.243:8080";

  static const Url = "https://4931-112-78-36-14.ngrok-free.app";
  // static const Url = "https://yamanaka1.pagekite.me";

  static const Url_pred = "${ApiUrl.Url}/upload";
  static const Url_total_models = "${ApiUrl.Url}/count_models";
  static const Url_selected_models = "${ApiUrl.Url}/selected_models";
  static const Url_delete_img = '${ApiUrl.Url}/delete_img';

  static const Url_model = '${ApiUrl.Url}/upload_data';
  static const Url_total_files = '${ApiUrl.Url}/get_total_files';
  static const Url_preprocessing = '${ApiUrl.Url}/do_preprocessing';

  static const Url_img_preprocess =
      '${ApiUrl.Url}/get_random_images_preprocess';

  static const Url_train_model = '${ApiUrl.Url}/do_training';
  static const Url_import_model = '${ApiUrl.Url}/upload_model';
  static const Url_params = '${ApiUrl.Url}/set_params';

  static const Url_get_info = '${ApiUrl.Url}/get_info';
  static const Url_fetch_progress = '${ApiUrl.Url}/progress';
}
