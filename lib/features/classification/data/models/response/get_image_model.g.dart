// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetImageModel _$GetImageModelFromJson(Map<String, dynamic> json) =>
    GetImageModel(
      urls: (json['urls'] as List<dynamic>?)?.map((e) => e as String).toList(),
      bentukWajah: json['bentuk_wajah'] as String?,
      persen: (json['persen'] as num?)?.toDouble(),
    );
