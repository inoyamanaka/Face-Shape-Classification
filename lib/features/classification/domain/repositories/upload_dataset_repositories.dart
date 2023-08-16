import 'package:flutter/material.dart';

abstract class UploadDatasetRepository {
  Future<bool> uploadDataset(
      String filepath, ValueNotifier<double> loadingController);
}
