// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetImageModel _$GetImageModelFromJson(Map<String, dynamic> json) =>
    GetImageModel(
      (json['urls'] as List<dynamic>).map((e) => e as String).toList(),
      json['bentuk_wajah'] as String,
      (json['persentase'] as num).toDouble(),
    );
