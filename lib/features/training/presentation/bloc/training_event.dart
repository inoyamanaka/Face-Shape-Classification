// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'training_bloc.dart';

abstract class TrainingEvent extends Equatable {
  const TrainingEvent();

  @override
  List<Object> get props => [];
}

class UploadDatasetEvent extends TrainingEvent {
  final UploadDatasetFilepathReq filepath;
  const UploadDatasetEvent({
    required this.filepath,
  });
}
