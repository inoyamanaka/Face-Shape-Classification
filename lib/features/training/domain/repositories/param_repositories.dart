import 'package:dartz/dartz.dart';
import 'package:face_shape/core/error/failures.dart';
import 'package:face_shape/features/training/data/models/request/param_body.dart';
import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';

abstract class ParamRepository {
  Future<Either<Failure, ParamEntity>> setParams(ParamBody body);
}
