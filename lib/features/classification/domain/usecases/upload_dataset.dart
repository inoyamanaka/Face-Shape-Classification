import 'package:face_shape/features/classification/data/repositories/upload_dataset_repositories_impl.dart';
import 'package:face_shape/features/classification/domain/repositories/upload_dataset_repositories.dart';
import 'package:flutter/material.dart';

class UploadDataset {
  UploadDatasetRepository uploadDataseteRepository =
      UploadDataseRepositorytImpl();

  // UploadDataset();

  Future<bool> call(
      String filepath, ValueNotifier<double> loadingController) async {
    return await uploadDataseteRepository.uploadDataset(
        filepath, loadingController);
  }
}
