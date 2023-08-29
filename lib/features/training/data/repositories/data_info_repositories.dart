import 'package:dartz/dartz.dart';
import 'package:face_shape/core/error/failures.dart';
import 'package:face_shape/features/training/data/datasources/data_info_datasource.dart';
import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';
import 'package:face_shape/features/training/domain/repositories/data_info_repositories.dart';

class DataInfoRepositoriesImpl implements DataInfoRepository {
  final DataInfoDataSource dataSource;

  DataInfoRepositoriesImpl(this.dataSource);
  @override
  Future<Either<Failure, DataInfoEntity>> getDataInfo() async {
    final remoteInfo = await dataSource.getInfoData();
    return Right(remoteInfo);
  }
}
