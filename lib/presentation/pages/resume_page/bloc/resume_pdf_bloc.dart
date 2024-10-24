import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freelance/db/model/cv_pdf_model.dart';
import 'package:freelance/db/services/firebase_database_usersaving_functions.dart';

part 'resume_pdf_event.dart';
part 'resume_pdf_state.dart';

class ResumePdfBloc extends Bloc<ResumePdfEvent, ResumePdfState> {
  ResumePdfBloc() : super(ResumePdfInitial()) {
    on<ResumePdfEvent>((event, emit) {});
    on<ResumePdfFetch>(resumeFetch);
  }

  FutureOr<void> resumeFetch(
      ResumePdfFetch event, Emitter<ResumePdfState> emit)async {
    try {
      emit(ResumeLoadingState());
      final resume = await UserDatabaseFunctions().getResume(event.userId);
      if (resume == null) {
        emit(ResumeEmpty());
      }
      emit(ResumeLoaded(resume: resume!));
    } on FirebaseException catch (e) {
      (e);
    }
  }
}
