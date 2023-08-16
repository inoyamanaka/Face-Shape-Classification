part of 'training_bloc.dart';

abstract class TrainingState extends Equatable {
  const TrainingState();  

  @override
  List<Object> get props => [];
}
class TrainingInitial extends TrainingState {}
