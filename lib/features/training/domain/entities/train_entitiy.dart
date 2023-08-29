// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
class ParamEntity extends Equatable {
  const ParamEntity({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [message];
}

class UploadDatasetEntity extends Equatable {
  const UploadDatasetEntity({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [message];
}

class DataInfoEntity extends Equatable {
  String optimizer;
  int epoch;
  int batchSize;
  List<int> trainingCounts;
  List<int> testingCounts;

  DataInfoEntity({
    required this.optimizer,
    required this.epoch,
    required this.batchSize,
    required this.trainingCounts,
    required this.testingCounts,
  });

  @override
  List<Object?> get props =>
      [optimizer, epoch, batchSize, trainingCounts, testingCounts];
}

class TrainPreprocessEntity extends Equatable{
  List<String> faceCrop;
    List<String> faceLandmark;
    List<String> landmarkExtraction;

    TrainPreprocessEntity({
        required this.faceCrop,
        required this.faceLandmark,
        required this.landmarkExtraction,
    });
    
      @override
      List<Object?> get props => [faceCrop, faceLandmark, landmarkExtraction];

}

class TrainResultEntity extends Equatable{
  double trainAcc;
    double valAcc;
    String plotAcc;
    String plotLoss;
    String conf;

    TrainResultEntity({
        required this.trainAcc,
        required this.valAcc,
        required this.plotAcc,
        required this.plotLoss,
        required this.conf,
    });
    
      @override
      List<Object?> get props => [trainAcc, valAcc, plotAcc, plotLoss, conf];
}