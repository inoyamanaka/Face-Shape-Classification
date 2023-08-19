// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'classification_bloc.dart';

sealed class UploadClassificationEvent extends Equatable {
  const UploadClassificationEvent();

  @override
  List<Object> get props => [];
}

sealed class GetClassificationEvent extends Equatable {
  const GetClassificationEvent();

  @override
  List<Object> get props => [];
}

class UploadEvent extends UploadClassificationEvent {
  final UploadImageModel filepath;
  const UploadEvent({
    required this.filepath,
  });
}

class GetEvent extends GetClassificationEvent {}
