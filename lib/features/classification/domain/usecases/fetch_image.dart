import 'package:face_shape/features/classification/data/repositories/fetch_image_repositories_impl.dart';
import 'package:face_shape/features/classification/domain/entities/user_image.dart';
import 'package:face_shape/features/classification/domain/repositories/fetch_image_repositories.dart';

class FetchImage {
  FetchImageRepository fetchImageRepository = FetchImageRepositoryImpl();

  Future<UserImage> call(String filepath) async {
    return await fetchImageRepository.fetchUserImageAtt();
  }
}
