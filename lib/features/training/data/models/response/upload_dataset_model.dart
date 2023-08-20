import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_dataset_model.g.dart';

@JsonSerializable(createToJson: false)
class UploadDatasetModel extends UploadDatasetEntity {
  const UploadDatasetModel({required super.message});

  factory UploadDatasetModel.fromJson(Map<String, dynamic> json) =>
      _$UploadDatasetModelFromJson(json);
}
