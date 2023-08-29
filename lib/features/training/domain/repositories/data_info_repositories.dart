import 'package:dartz/dartz.dart';
import 'package:face_shape/core/error/failures.dart';
import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';

abstract class DataInfoRepository {
  Future<Either<Failure, DataInfoEntity>> getDataInfo();
}
