import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:face_shape/features/training/data/models/request/upload_dataset_filepath.dart';
import 'package:face_shape/features/training/domain/usecases/upload_dataset.dart';

part 'training_event.dart';
part 'training_state.dart';

class UploadDatasetBloc extends Bloc<TrainingEvent, UploadDatasetState> {
  UploadDatasetUseCase uploadDatasetUseCase;
  UploadDatasetBloc(this.uploadDatasetUseCase)
      : super(UploadDatasetStateInitial()) {
    on<UploadDatasetEvent>((event, emit) async {
      emit(UploadDatasetStateLoading());
      final failureOrSuccess = await uploadDatasetUseCase.call(event.filepath);
      failureOrSuccess.fold(
        (error) => emit(UploadDatasetStateFailure()),
        (data) => emit(UploadDatasetStateSuccess()),
      );
    });
  }
}
