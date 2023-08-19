// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetImageModel _$GetImageModelFromJson(Map<String, dynamic> json) =>
    GetImageModel(
      bentukWajah: json['bentuk_wajah'] as String,
      persentase: (json['persen'] as num).toDouble(),
      urls: (json['urls'] as List<dynamic>).map((e) => e as String).toList(),
    );
