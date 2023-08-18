import 'package:face_shape/core/error/failures.dart';
import 'package:face_shape/features/classification/domain/entities/user_image.dart';
import 'package:dartz/dartz.dart';

abstract class UploadImageRepository {
  Future<Either<Failure, ImageEntity>> uploadImage(String filePath);
}
