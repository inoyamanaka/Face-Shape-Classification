import 'package:dartz/dartz.dart';
import 'package:face_shape/core/error/failures.dart';
import 'package:face_shape/core/models/usecase/usecase.dart';
import 'package:face_shape/features/training/data/models/request/upload_dataset_filepath.dart';
import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';
import 'package:face_shape/features/training/domain/repositories/upload_dataset_repositories.dart';

class UploadDatasetUseCase
    extends UseCase<UploadDatasetEntity, UploadDatasetFilepathReq> {
  final UploadDatasetRepository uploadDatasetRepository;

  UploadDatasetUseCase(this.uploadDatasetRepository);
  @override
  Future<Either<Failure, UploadDatasetEntity>> call(
      UploadDatasetFilepathReq params) {
    return uploadDatasetRepository.upload(params);
  }
}

class UploadProgressUseCase {
  double calculateProgress(int sentBytes, int totalBytes) {
    return (sentBytes / totalBytes) * 100 / 100;
  }
}
