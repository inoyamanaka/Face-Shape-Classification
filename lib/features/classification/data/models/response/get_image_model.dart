import 'package:json_annotation/json_annotation.dart';
import 'package:face_shape/features/classification/domain/entities/user_image.dart';

part 'get_image_model.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class GetImageModel extends DataImageEntity {
  const GetImageModel(
      {required super.urls,
      required super.bentukWajah,
      required super.persen});

  factory GetImageModel.fromJson(Map<String, dynamic> json) =>
      _$GetImageModelFromJson(json);
}
