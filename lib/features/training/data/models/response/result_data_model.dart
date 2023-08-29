// ignore_for_file: must_be_immutable

import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';
import 'package:json_annotation/json_annotation.dart';
part 'result_data_model.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class TrainPreprocessModel extends TrainPreprocessEntity {
  TrainPreprocessModel(
      {
      required super.faceLandmark,
      required super.landmarkExtraction});

  factory TrainPreprocessModel.fromJson(Map<String, dynamic> json) =>
      _$TrainPreprocessModelFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class TrainResultModel extends TrainResultEntity {
  TrainResultModel(
      {required super.trainAcc,
      required super.valAcc,
      required super.plotAcc,
      required super.plotLoss,
      required super.conf});

  factory TrainResultModel.fromJson(Map<String, dynamic> json) =>
      _$TrainResultModelFromJson(json);
}
