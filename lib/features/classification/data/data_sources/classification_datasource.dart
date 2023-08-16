import 'package:face_shape/features/classification/domain/entities/user_image.dart';

abstract class ClassificationRemoteDataSource{
  Future<ImageEntity> getImage()
}