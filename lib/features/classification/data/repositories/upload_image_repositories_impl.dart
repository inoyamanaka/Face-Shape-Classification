import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:face_shape/core/error/failures.dart';
import 'package:face_shape/features/classification/data/data_sources/classification_datasource_request.dart';
import 'package:face_shape/features/classification/domain/entities/user_image.dart';
import 'package:face_shape/features/classification/domain/repositories/upload_image_repositories.dart';

class UploadImageRepositoryImpl extends UploadImageRepository {
  final ReqClassificationRemoteDataSource datasource;

  UploadImageRepositoryImpl(this.datasource);
  @override
  Future<Either<Failure, ImageEntity>> uploadImage(String filePath) async {
    try {
      final remoteGetImage = await datasource.uploadImage(filePath);

      return Right(remoteGetImage);
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        log('${e.response!.data}');
        log('${e.response!.headers}');
        return Left(
          ServerFailure.fromJson(e.response!.data as Map<String, dynamic>),
        );
      } else {
        // Something happened in setting up or sending the request
        //that triggered an Error
        log(e.message!);
        return Left(ServerFailure(e.message!));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
