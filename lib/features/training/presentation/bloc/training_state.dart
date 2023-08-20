part of 'training_bloc.dart';

abstract class UploadDatasetState extends Equatable {
  const UploadDatasetState();

  @override
  List<Object> get props => [];
}

// UPLOAD DATASET STATE

class UploadDatasetStateInitial extends UploadDatasetState {}

class UploadDatasetStateLoading extends UploadDatasetState {}

class UploadDatasetStateFailure extends UploadDatasetState {}

class UploadDatasetStateSuccess extends UploadDatasetState {}
