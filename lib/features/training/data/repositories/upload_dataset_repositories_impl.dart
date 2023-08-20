// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:face_shape/core/error/failures.dart';
import 'package:face_shape/features/training/data/datasources/upload_dataset_datasource.dart';
import 'package:face_shape/features/training/data/models/request/upload_dataset_filepath.dart';
import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';
import 'package:face_shape/features/training/domain/repositories/upload_dataset_repositories.dart';

class UploadDatasetRepositoryImpl implements UploadDatasetRepository {
  final UploadDatasetDataSource uploadDatasetDataSource;
  UploadDatasetRepositoryImpl(this.uploadDatasetDataSource);

  @override
  Future<Either<Failure, UploadDatasetEntity>> upload(
      UploadDatasetFilepathReq filepath) async {
    final remoteUploadMessage = await uploadDatasetDataSource.upload(filepath);
    return Right(remoteUploadMessage);
  }
}
