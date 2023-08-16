import 'package:face_shape/core/models/error/failures.dart';
import 'package:face_shape/features/classification/domain/entities/user_image.dart';
import 'package:dartz/dartz.dart';

abstract class UploadImageRepository {
  Future<Either<Failure, ImageEntitiy>> uploadImage(String filePath);
}
