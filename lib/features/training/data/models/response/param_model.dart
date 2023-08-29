import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';
import 'package:json_annotation/json_annotation.dart';

part 'param_model.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ParamModel extends ParamEntity {
  const ParamModel({required super.message});

  factory ParamModel.fromJson(Map<String, dynamic> json) =>
      _$ParamModelFromJson(json);
}
