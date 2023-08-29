import 'package:dartz/dartz.dart';
import 'package:face_shape/core/error/failures.dart';
import 'package:face_shape/features/training/data/datasources/settings_parameter.dart';
import 'package:face_shape/features/training/data/models/request/param_body.dart';
import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';
import 'package:face_shape/features/training/domain/repositories/param_repositories.dart';

class ParamRespositoryImpl implements ParamRepository {
  final ParamDataSource datasource;

  ParamRespositoryImpl(this.datasource);

  @override
  Future<Either<Failure, ParamEntity>> setParams(ParamBody body) async {
    // print(body.batchSize);
    // print(body.epoch);
    // print(body.optimizer);

    final remoteParam = await datasource.setParams(body);
    print(remoteParam);
    return Right(remoteParam);
  }
}
