import 'package:json_annotation/json_annotation.dart';

part 'train_request.g.dart';

@JsonSerializable(createFactory: false)
class UploadDatasetFilepathReq {
  UploadDatasetFilepathReq({
    required this.filepath,
  });
  final String filepath;

  Map<String, dynamic> toJson() => _$UploadDatasetFilepathReqToJson(this);
}
