part of 'classification_bloc.dart';

sealed class ClassificationState extends Equatable {
  const ClassificationState();

  @override
  List<Object> get props => [];
}

final class ClassificationInitial extends ClassificationState {}

final class ClassificationLoading extends ClassificationState {}

final class ClassificationFailure extends ClassificationState {
  final String message;

  const ClassificationFailure(this.message);
}

final class ClassificationSuccess extends ClassificationState {}
