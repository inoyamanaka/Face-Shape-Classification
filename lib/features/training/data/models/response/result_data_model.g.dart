// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrainPreprocessModel _$TrainPreprocessModelFromJson(
        Map<String, dynamic> json) =>
    TrainPreprocessModel(
      faceCrop:
          (json['face_crop'] as List<dynamic>).map((e) => e as String).toList(),
      faceLandmark: (json['face_landmark'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      landmarkExtraction: (json['landmark_extraction'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

TrainResultModel _$TrainResultModelFromJson(Map<String, dynamic> json) =>
    TrainResultModel(
      trainAcc: (json['train_acc'] as num).toDouble(),
      valAcc: (json['val_acc'] as num).toDouble(),
      plotAcc: json['plot_acc'] as String,
      plotLoss: json['plot_loss'] as String,
      conf: json['conf'] as String,
    );
