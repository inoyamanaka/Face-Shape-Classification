import 'package:face_shape/features/classification/data/repositories/upload_image_repositories_impl.dart';
import 'package:face_shape/features/classification/domain/repositories/upload_image_repositories.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage {
  UploadImageRepository uploadImageRepository = UploadImageRepositoryImpl();

  Future<bool> call(String filepath) async {
    return await uploadImageRepository.uploadImage(filepath);
  }
}
