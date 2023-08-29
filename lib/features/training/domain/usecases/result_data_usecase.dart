import 'package:dartz/dartz.dart';
import 'package:face_shape/core/error/failures.dart';
import 'package:face_shape/core/models/usecase/usecase.dart';
import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';
import 'package:face_shape/features/training/domain/repositories/result_data_repositories.dart';

class TrainPreprocessUseCase extends UseCase<TrainPreprocessEntity, NoParams> {
  final TrainPreprocessRepository trainPreprocessRepository;

  TrainPreprocessUseCase(this.trainPreprocessRepository);
  @override
  Future<Either<Failure, TrainPreprocessEntity>> call(NoParams params) {
    return trainPreprocessRepository.getImagePreprocess();
  }
}

class TrainResultUseCase extends UseCase<TrainResultEntity, NoParams> {
  final TrainResultRepository trainResultRepository;

  TrainResultUseCase(this.trainResultRepository);

  @override
  Future<Either<Failure, TrainResultEntity>> call(NoParams params) {
    return trainResultRepository.getTrainResult();
  }
}
