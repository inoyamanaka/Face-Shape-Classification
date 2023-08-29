// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataInfoModel _$DataInfoModelFromJson(Map<String, dynamic> json) =>
    DataInfoModel(
      optimizer: json['optimizer'] as String,
      epoch: json['epoch'] as int,
      batchSize: json['batch_size'] as int,
      trainingCounts: (json['training_counts'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      testingCounts: (json['testing_counts'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );
