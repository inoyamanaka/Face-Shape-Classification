import 'package:json_annotation/json_annotation.dart';
import 'package:face_shape/features/classification/domain/entities/user_image.dart';

part 'get_image_model.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class GetImageModel extends DataImageEntity {
  GetImageModel(List<String> urls, String bentukWajah, double persentase)
      : super(urls, bentukWajah, persentase);

  factory GetImageModel.fromJson(Map<String, dynamic> json) =>
      _$GetImageModelFromJson(json);
}
