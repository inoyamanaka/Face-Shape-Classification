import 'package:dartz/dartz.dart';
import 'package:face_shape/core/error/failures.dart';
import 'package:face_shape/features/classification/domain/entities/user_image.dart';

abstract class GetImageRepository {
  Future<Either<Failure, DataImageEntity>> getImageAtt();
}
