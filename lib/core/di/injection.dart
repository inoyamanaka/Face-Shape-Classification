import 'package:dio/dio.dart';
import 'package:face_shape/features/classification/data/data_sources/classification_datasource_request.dart';
import 'package:face_shape/features/classification/data/data_sources/classification_datasource_response.dart';
import 'package:face_shape/features/classification/data/repositories/fetch_image_repositories_impl.dart';
import 'package:face_shape/features/classification/data/repositories/upload_image_repositories_impl.dart';
import 'package:face_shape/features/classification/domain/repositories/fetch_image_repositories.dart';
import 'package:face_shape/features/classification/domain/repositories/upload_image_repositories.dart';
import 'package:face_shape/features/classification/domain/usecases/fetch_image.dart';
import 'package:face_shape/features/classification/domain/usecases/upload_image.dart';
import 'package:face_shape/features/classification/presentation/bloc/classification_bloc.dart';
import 'package:face_shape/features/training/data/datasources/upload_dataset_datasource.dart';
import 'package:face_shape/features/training/data/repositories/upload_dataset_repositories_impl.dart';
import 'package:face_shape/features/training/domain/repositories/upload_dataset_repositories.dart';
import 'package:face_shape/features/training/domain/usecases/upload_dataset.dart';
import 'package:face_shape/features/training/presentation/bloc/training_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class Injection {
  Future<void> init() async {
    sl
      ..registerLazySingleton<Dio>(
        () => Dio(),
      )
      //CLASSIFICATION
      ..registerLazySingleton<ReqClassificationRemoteDataSource>(
        () => ReqClassificationRemoteDataSourceImpl(sl()),
      )
      ..registerLazySingleton<ResClassificationRemoteDataSource>(
        () => ResClassificationRemoteDataSourceImpl(sl()),
      )
      ..registerLazySingleton<UploadImageRepository>(
        () => UploadImageRepositoryImpl(sl()),
      )
      ..registerLazySingleton<GetImageRepository>(
        () => GetImageRepositoryImpl(sl()),
      )
      ..registerLazySingleton(
        () => UploadImageUsecase(sl()),
      )
      ..registerLazySingleton(
        () => GetImageUsecase(sl()),
      )
      ..registerFactory(() => ClassificationBlocGet(sl()))
      ..registerFactory<ClassificationBlocUpload>(
          () => ClassificationBlocUpload(sl()))

      // TRAINING
      ..registerLazySingleton<UploadDatasetDataSource>(
        () => UploadDatasetDataSourceImpl(sl()),
      )
      ..registerLazySingleton<UploadDatasetRepository>(
        () => UploadDatasetRepositoryImpl(sl()),
      )
      ..registerLazySingleton(
        () => UploadDatasetUseCase(sl()),
      )
      ..registerFactory(() => UploadDatasetBloc(sl()));
  }
}
