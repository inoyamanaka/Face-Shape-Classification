import 'package:dartz/dartz.dart';
import 'package:face_shape/core/error/failures.dart';
import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';

abstract class TrainPreprocessRepository {
  Future<Either<Failure, TrainPreprocessEntity>> getImagePreprocess();
}

abstract class TrainResultRepository {
  Future<Either<Failure, TrainResultEntity>> getTrainResult();
}
