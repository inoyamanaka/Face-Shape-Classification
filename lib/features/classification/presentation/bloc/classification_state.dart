part of 'classification_bloc.dart';

sealed class UploadClassificationState extends Equatable {
  const UploadClassificationState();

  @override
  List<Object> get props => [];
}

sealed class GetClassificationState extends Equatable {
  const GetClassificationState();

  @override
  List<Object> get props => [];
}

// Upload state
final class UploadClassificationInitial extends UploadClassificationState {}

final class UploadClassificationLoading extends UploadClassificationState {}

final class UploadClassificationFailure extends UploadClassificationState {
  const UploadClassificationFailure(this.message);
  final String message;
}

final class UploadClassificationSuccess extends UploadClassificationState {
  const UploadClassificationSuccess(this.imageEntity);
  final ImageEntity imageEntity;
}

// Get state
final class GetClassificationInitial extends GetClassificationState {}

final class GetClassificationLoading extends GetClassificationState {}

final class GetClassificationFailure extends GetClassificationState {
  final String message;

  const GetClassificationFailure(this.message);
}

final class GetClassificationSuccess extends GetClassificationState {
  final DataImageEntity dataImageEntity;

  const GetClassificationSuccess(this.dataImageEntity);
}
