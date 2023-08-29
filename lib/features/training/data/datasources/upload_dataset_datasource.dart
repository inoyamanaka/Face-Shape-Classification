import 'dart:async';

import 'package:dio/dio.dart';
import 'package:face_shape/config/config_url.dart';
import 'package:face_shape/features/training/data/models/request/train_request.dart';
import 'package:face_shape/features/training/data/models/response/upload_dataset_model.dart';
import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';

abstract class UploadDatasetDataSource {
  Future<UploadDatasetEntity> upload(UploadDatasetFilepathReq filepath);
}

class UploadDatasetDataSourceImpl implements UploadDatasetDataSource {
  final Dio client;

  UploadDatasetDataSourceImpl(this.client);

  @override
  Future<UploadDatasetEntity> upload(
    UploadDatasetFilepathReq filepath,
  ) async {
    try {
      final formData = FormData.fromMap({
        'file':
            await MultipartFile.fromFile(filepath.filepath, filename: 'file'),
      });

      final response = await client.post(ApiUrl.Url_model, data: formData,
          onSendProgress: (int sentBytes, int totalBytes) {
        double progressPercent = (sentBytes / totalBytes) * 100 / 100;
        print(progressPercent);
      });

      return UploadDatasetModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
