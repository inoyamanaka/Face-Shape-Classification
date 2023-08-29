// ignore_for_file: must_be_immutable

import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_info_model.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class DataInfoModel extends DataInfoEntity {
  DataInfoModel(
      {required super.optimizer,
      required super.epoch,
      required super.batchSize,
      required super.trainingCounts,
      required super.testingCounts});

  factory DataInfoModel.fromJson(Map<String, dynamic> json) =>
      _$DataInfoModelFromJson(json);
}
