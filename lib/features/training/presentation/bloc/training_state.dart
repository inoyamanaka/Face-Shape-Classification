part of 'training_bloc.dart';

abstract class TrainState extends Equatable {
  const TrainState();

  @override
  List<Object> get props => [];
}

// UPLOAD DATASET STATE

class UploadDatasetStateInitial extends TrainState {}

class UploadDatasetStateLoading extends TrainState {}

class UploadDatasetStateFailure extends TrainState {}

class UploadDatasetStateSuccess extends TrainState {}

// SET PARAMETER STATE

class SetParamStateInitial extends TrainState {}

class SetParamStateLoading extends TrainState {}

class SetParamStateFailure extends TrainState {}

class SetParamStateSuccess extends TrainState {}

// GET DATA INFO

class GetInfoStateInitial extends TrainState {}

class GetInfoStateLoading extends TrainState {}

class GetInfoStateFailure extends TrainState {}

class GetInfoStateSuccess extends TrainState {
  final DataInfoEntity result;

  const GetInfoStateSuccess(this.result);
}
