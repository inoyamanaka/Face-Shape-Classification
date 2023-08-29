// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'param_body.g.dart';

@JsonSerializable(createFactory: false)
class ParamBody {
  final String optimizer;
  final int batchSize;
  final int epoch;
  ParamBody({
    required this.optimizer,
    required this.batchSize,
    required this.epoch,
  });

  Map<String, dynamic> toJson() => _$ParamBodyToJson(this);
}
