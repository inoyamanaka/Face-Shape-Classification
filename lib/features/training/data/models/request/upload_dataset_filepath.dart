import 'package:json_annotation/json_annotation.dart';

part 'upload_dataset_filepath.g.dart';

@JsonSerializable(createFactory: false)
class UploadDatasetFilepathReq {
  UploadDatasetFilepathReq({
    required this.filepath,
  });
  final String filepath;

  Map<String, dynamic> toJson() => _$UploadDatasetFilepathReqToJson(this);
}
