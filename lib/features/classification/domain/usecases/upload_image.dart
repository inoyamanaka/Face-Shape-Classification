import 'package:dartz/dartz.dart';
import 'package:face_shape/core/error/failures.dart';
import 'package:face_shape/core/models/usecase/usecase.dart';
import 'package:face_shape/features/classification/data/models/request/upload_image_model.dart';
import 'package:face_shape/features/classification/domain/entities/user_image.dart';
import 'package:face_shape/features/classification/domain/repositories/upload_image_repositories.dart';

class UploadImageUsecase extends UseCase<ImageEntity, UploadImageModel> {
  final UploadImageRepository _repository;

  UploadImageUsecase(this._repository);

  @override
  Future<Either<Failure, ImageEntity>> call(UploadImageModel params) {
    return _repository.uploadImage(params);
  }
}
