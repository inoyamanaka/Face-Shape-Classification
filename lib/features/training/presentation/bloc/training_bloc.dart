// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:face_shape/core/models/usecase/usecase.dart';
import 'package:face_shape/features/training/data/models/request/param_body.dart';
import 'package:face_shape/features/training/data/models/request/train_request.dart';
import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';
import 'package:face_shape/features/training/domain/usecases/data_info_usecase.dart';
import 'package:face_shape/features/training/domain/usecases/set_params.dart';
import 'package:face_shape/features/training/domain/usecases/upload_dataset.dart';

part 'training_event.dart';
part 'training_state.dart';

class TrainBloc extends Bloc<TrainEvent, TrainState> {
  TrainBloc(
      this.uploadDatasetUseCase, this.setParamUseCase, this.dataInfoUseCase)
      : super(UploadDatasetStateInitial()) {
    // Upload dataset bloc
    on<UploadDatasetEvent>((event, emit) async {
      emit(UploadDatasetStateLoading());
      final failureOrSuccess = await uploadDatasetUseCase.call(event.filepath);
      failureOrSuccess.fold(
        (error) => emit(UploadDatasetStateFailure()),
        (data) => emit(UploadDatasetStateSuccess()),
      );
    });
    on<SetParamEvent>(((event, emit) async {
      emit(SetParamStateLoading());
      final failureOrSuccess = await setParamUseCase.call(event.body);
      failureOrSuccess.fold(
        (error) => emit(SetParamStateFailure()),
        (data) => emit(SetParamStateSuccess()),
      );
    }));
    on<GetInfoEvent>(((event, emit) async {
      emit(GetInfoStateLoading());
      final failureOrSuccess = await dataInfoUseCase.call(NoParams());
      failureOrSuccess.fold(
        (error) => emit(GetInfoStateFailure()),
        (data) => emit(GetInfoStateSuccess(data)),
      );
    }));
  }
  UploadDatasetUseCase uploadDatasetUseCase;
  SetParamsUseCase setParamUseCase;
  DataInfoUseCase dataInfoUseCase;
}
