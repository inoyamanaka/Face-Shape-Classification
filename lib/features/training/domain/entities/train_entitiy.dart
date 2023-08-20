import 'package:equatable/equatable.dart';

class TrainEntity {
  String trainAcc;
  String valAcc;
  String plotAcc;
  String plotLoss;
  String conf;

  TrainEntity({
    required this.trainAcc,
    required this.valAcc,
    required this.plotAcc,
    required this.plotLoss,
    required this.conf,
  });
}

class ParameterEntity {
  String fungsiAktivasi;
  int jumlahEpoch;
  int batchSize;

  ParameterEntity({
    required this.fungsiAktivasi,
    required this.jumlahEpoch,
    required this.batchSize,
  });
}

class UploadDatasetEntity extends Equatable {
  const UploadDatasetEntity({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [message];
}

class DatasetEntity {
  int training;
  int testing;

  DatasetEntity({
    required this.training,
    required this.testing,
  });
}
