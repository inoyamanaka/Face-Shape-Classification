import 'package:dartz/dartz.dart';
import 'package:face_shape/core/error/failures.dart';
import 'package:face_shape/core/models/usecase/usecase.dart';
import 'package:face_shape/features/training/data/models/request/param_body.dart';
import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';
import 'package:face_shape/features/training/domain/repositories/param_repositories.dart';

class SetParamsUseCase extends UseCase<ParamEntity, ParamBody> {
  final ParamRepository paramRepository;

  SetParamsUseCase(this.paramRepository);
  @override
  Future<Either<Failure, ParamEntity>> call(ParamBody params) {
    return paramRepository.setParams(params);
  }
}
