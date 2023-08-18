import 'package:face_shape/features/classification/domain/entities/user_image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_image_model.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class UploadImageModel extends ImageEntity {
  const UploadImageModel({required super.message});

  factory UploadImageModel.fromJson(Map<String, dynamic> json) =>
      _$UploadImageModelFromJson(json);
}
