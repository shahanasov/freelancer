import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelance/db/functions/firebaseauth.dart';
import 'package:freelance/db/functions/firebasedatabase.dart';
import 'package:freelance/db/model/userdetails.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  final UserDatabaseFunctions storage;
  final Authentication auth;
  ProfilePageBloc( {required this.storage,required this.auth}) : super(ProfilePageInitial()) {
    on<ProfilePageEvent>((event, emit) {});

    on<ProfileLoadEvent>(getuserDetails);

    // on<TabEvent>((event, emit) {
    //   if (event is PostTabEvent) {
    //     emit(PostTabState());
    //   } else if (event is WorksTabEvent) {
    //     emit(WorkTabState());
    //   } else if (event is ResumeTabEvent) {
    //     emit(ResumeTabState());
    //   } else {
    //     emit(PostTabState());
    //   }
    // });
  }

  Future<void> getuserDetails(
      ProfileLoadEvent event, Emitter<ProfilePageState> emit) async {
        
    emit(ProfileLoadingState());
    log('loading');
    try {
      final UserDetailsModel? userDetailsModel =
          await storage.gettingDetailsofTheUser();
      if (userDetailsModel != null) {
        log('loading1');
        emit(ProfileLoadedState(profile: userDetailsModel));
      } else {
        log('loading2');
        emit(ProfileErrorState('User details not found '));
      }
    }on FirebaseException catch (e) {
      log(e.code);
      emit(ProfileErrorState(e.toString()));
    }
  }
}
