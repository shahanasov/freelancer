import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freelance/db/functions/firebasedatabase.dart';
import 'package:freelance/db/model/filesmodel.dart';


part 'upload_resume_event.dart';
part 'upload_resume_state.dart';

class UploadResumeBloc extends Bloc<UploadResumeEvent, UploadResumeState> {
  UploadResumeBloc() : super(UploadResumeInitial()) {
    on<UploadResumeEvent>(upload);
  }

  FutureOr<void> upload(UploadResumeEvent event, Emitter<UploadResumeState> emit)async {
//somewhere  need to give loadingstate while waiting
    if(event is UploadingEvent){
      try{
        // here
       FilesModel? filesModel= await UserDatabaseFunctions().cvUpload(filesModel: FilesModel());
        emit(UploadedResume(filesModel: filesModel));
      }catch (e){
        emit(ErrorUploadState());
      }
    }
  }
}
