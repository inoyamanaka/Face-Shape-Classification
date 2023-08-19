import 'package:face_shape/core/error/failures.dart';
import 'package:face_shape/features/classification/data/models/request/upload_image_model.dart';
import 'package:face_shape/features/classification/domain/entities/user_image.dart';
import 'package:dartz/dartz.dart';

abstract class UploadImageRepository {
  Future<Either<Failure, ImageEntity>> uploadImage(UploadImageModel filePath);
}
