import 'package:dartz/dartz.dart';
import 'package:face_shape/core/error/failures.dart';
import 'package:face_shape/core/models/usecase/usecase.dart';
import 'package:face_shape/features/classification/domain/repositories/upload_image_repositories.dart';

class UploadImageUsecase extends UseCase {
  final UploadImageRepository _repository;

  UploadImageUsecase(this._repository);

  @override
  Future<Either<Failure, dynamic>> call(params) {
    return _repository.uploadImage(params);
  }
}
