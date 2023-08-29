import 'package:dartz/dartz.dart';
import 'package:face_shape/core/error/failures.dart';
import 'package:face_shape/features/training/data/datasources/result_data_datasource.dart';
import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';
import 'package:face_shape/features/training/domain/repositories/result_data_repositories.dart';

class TrainPreprocessRepositoryImpl implements TrainPreprocessRepository {
  final TrainPreprocessDataSource dataSource;

  TrainPreprocessRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, TrainPreprocessEntity>> getImagePreprocess() async {
    final result = await dataSource.getImagePreprocess();
    return Right(result);
  }
}

class TrainResultRepositoryImpl implements TrainResultRepository {
  final TrainResultDataSource dataSource;

  TrainResultRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, TrainResultEntity>> getTrainResult() async {
    final response = await dataSource.getTrainResult();
    return Right(response);
  }
}
