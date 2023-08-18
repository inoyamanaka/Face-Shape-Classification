import 'package:dartz/dartz.dart';
import 'package:face_shape/core/error/failures.dart';
import 'package:face_shape/core/models/usecase/usecase.dart';
import 'package:face_shape/features/classification/domain/repositories/fetch_image_repositories.dart';

class GetImageUsecase extends UseCase {
  final GetImageRepository _repository;

  GetImageUsecase(this._repository);

  @override
  Future<Either<Failure, dynamic>> call(params) {
    // TODO: implement call
    return _repository.getImageAtt(params);
  }
}
