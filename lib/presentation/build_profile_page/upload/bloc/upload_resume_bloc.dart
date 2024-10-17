import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freelance/db/services/firebase_database_usersaving_functions.dart';
import 'package:freelance/db/model/cv_pdf_model.dart';

part 'upload_resume_event.dart';
part 'upload_resume_state.dart';

class UploadResumeBloc extends Bloc<UploadResumeEvent, UploadResumeState> {
  UploadResumeBloc() : super(UploadResumeInitial()) {
    on<UploadResumeEvent>(upload);
  }

  FutureOr<void> upload(
      UploadResumeEvent event, Emitter<UploadResumeState> emit) async {
    if (event is UploadingEvent) {
      try {
        emit(UploadingResumeState());
        ResumeModel? resumeModel =
            await UserDatabaseFunctions().cvUpload(resumeModel: ResumeModel());
        if (resumeModel != null) {
          UserDatabaseFunctions().uploadResumetoDb(resumeModel: resumeModel);
        }
        emit(UploadedResume(resumeModel: resumeModel));
      } catch (e) {
        emit(ErrorUploadState());
      }
    }
  }
}
