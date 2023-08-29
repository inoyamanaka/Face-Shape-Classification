import 'package:dartz/dartz.dart';
import 'package:face_shape/core/error/failures.dart';
import 'package:face_shape/features/training/data/models/request/train_request.dart';
import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';

abstract class UploadDatasetRepository {
  Future<Either<Failure, UploadDatasetEntity>> upload(
      UploadDatasetFilepathReq filepath);
}
