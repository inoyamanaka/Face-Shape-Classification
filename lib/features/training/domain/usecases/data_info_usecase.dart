import 'package:dartz/dartz.dart';
import 'package:face_shape/core/error/failures.dart';
import 'package:face_shape/core/models/usecase/usecase.dart';
import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';
import 'package:face_shape/features/training/domain/repositories/data_info_repositories.dart';

class DataInfoUseCase extends UseCase<DataInfoEntity, NoParams> {
  final DataInfoRepository dataInfoRepository;

  DataInfoUseCase(this.dataInfoRepository);

  @override
  Future<Either<Failure, DataInfoEntity>> call(NoParams params) {
    return dataInfoRepository.getDataInfo();
  }
}
