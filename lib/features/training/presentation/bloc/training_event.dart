// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'training_bloc.dart';

abstract class TrainEvent extends Equatable {
  const TrainEvent();

  @override
  List<Object> get props => [];
}

class UploadDatasetEvent extends TrainEvent {
  final UploadDatasetFilepathReq filepath;
  const UploadDatasetEvent({
    required this.filepath,
  });
}

class SetParamEvent extends TrainEvent {
  final ParamBody body;
  const SetParamEvent({required this.body});
}

class GetInfoEvent extends TrainEvent {}

class GetImagePrepEvent extends TrainEvent {}

class GetTrainResultEvent extends TrainEvent {}
