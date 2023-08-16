import 'package:dio/dio.dart';
import 'package:face_shape/config/config_url.dart';
import 'package:face_shape/features/classification/domain/repositories/upload_dataset_repositories.dart';
import 'package:flutter/material.dart';

class UploadDataseRepositorytImpl implements UploadDatasetRepository {
  @override
  Future<bool> uploadDataset(
      String filepath, ValueNotifier<double> loadingController) async {
    final url = Uri.parse('${ApiUrl.Url_model}');
    try {
      Dio dio = new Dio();
      FormData formData = new FormData.fromMap(
          {'file': await MultipartFile.fromFile(filepath)});
      loadingController.value = 0.0;
      Response response = await dio.post(url.toString(), data: formData,
          onSendProgress: (int sentBytes, int totalBytes) {
        double progressPercent = (sentBytes / totalBytes) * 100 / 100;
        loadingController.value = progressPercent;
        print(progressPercent);
      });
    } catch (e) {
      return false;
    }
    return true;
  }
}
