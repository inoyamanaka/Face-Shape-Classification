import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'classification_event.dart';
part 'classification_state.dart';

class ClassificationBloc
    extends Bloc<ClassificationEvent, ClassificationState> {
  ClassificationBloc() : super(ClassificationInitial()) {
    on<ClassificationEvent>((event, emit) {
      emit(ClassificationLoading());

      // final failureOrSuccess = await
      // TODO: implement event handler
    });
  }
}
