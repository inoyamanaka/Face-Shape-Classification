import 'package:dio/dio.dart';
import 'package:face_shape/config/config_url.dart';
import 'package:face_shape/features/classification/data/models/request/upload_image_model.dart';
import 'package:face_shape/features/classification/domain/entities/user_image.dart';

abstract class ReqClassificationRemoteDataSource {
  Future<ImageEntity> uploadImage(UploadImageModel filepath);
}

class ReqClassificationRemoteDataSourceImpl
    implements ReqClassificationRemoteDataSource {
  final Dio client;

  ReqClassificationRemoteDataSourceImpl(this.client);

  @override
  Future<ImageEntity> uploadImage(UploadImageModel filePath) async {
    try {
      final formData = FormData.fromMap({
        'file':
            await MultipartFile.fromFile(filePath.message, filename: 'file'),
      });

      final response = await client.post(
        '${ApiUrl.Url_pred}',
        data: formData,
      );

      return UploadImageModel.fromJson(
          response.data!); // Placeholder return value, modify as needed
    } catch (error) {
      // Handle errors here
      return throw (error);
    }
  }
}
