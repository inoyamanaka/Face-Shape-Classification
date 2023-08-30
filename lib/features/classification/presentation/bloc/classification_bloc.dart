import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:face_shape/core/models/usecase/usecase.dart';
import 'package:face_shape/features/classification/data/models/request/upload_image_model.dart';
import 'package:face_shape/features/classification/domain/entities/user_image.dart';
import 'package:face_shape/features/classification/domain/usecases/fetch_image.dart';
import 'package:face_shape/features/classification/domain/usecases/upload_image.dart';

part 'classification_event.dart';
part 'classification_state.dart';

class ClassificationBlocUpload
    extends Bloc<UploadClassificationEvent, UploadClassificationState> {
  ClassificationBlocUpload(this.uploadImageUsecase)
      : super(UploadClassificationInitial()) {
    on<UploadEvent>((event, emit) async {
      emit(UploadClassificationLoading());

      final result = await uploadImageUsecase.call(event.filepath);

      result.fold((l) {
        emit(UploadClassificationFailure(l.message));
        // print(l.message);
      }, (r) {
        // print(r);
        emit(UploadClassificationSuccess(r));
      });
    });
  }
  UploadImageUsecase uploadImageUsecase;
}

class ClassificationBlocGet
    extends Bloc<GetClassificationEvent, GetClassificationState> {
  GetImageUsecase getImageUsecase;
  ClassificationBlocGet(this.getImageUsecase)
      : super(GetClassificationInitial()) {
    on<GetEvent>((event, emit) async {
      emit(GetClassificationLoading());
      final result = await getImageUsecase.call(NoParams());
      result.fold((l) {
        // print(l);
        emit(GetClassificationFailure(l.message));
      }, (r) {
        emit(GetClassificationSuccess(r));
      });
    });
  }
}
