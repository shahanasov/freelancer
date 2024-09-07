import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelance/db/services/firebaseauth.dart';
import 'package:freelance/db/services/firebase_database.dart';
import 'package:freelance/db/model/userdetails.dart';
import 'package:freelance/db/services/post_functions.dart';

import '../../../../../db/model/post_model.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  final UserDatabaseFunctions storage;
  final Authentication auth;
  ProfilePageBloc({required this.storage, required this.auth})
      : super(ProfilePageInitial()) {
    on<ProfilePageEvent>((event, emit) {});

    on<ProfileLoadEvent>(getuserDetails);
    // on<FetchUserPost>(getusersposts);
  }

  Future<void> getuserDetails(
      ProfileLoadEvent event, Emitter<ProfilePageState> emit) async {
    emit(ProfileLoadingState());
    // log('loading');
    try {
      final UserDetailsModel? userDetailsModel =
          await storage.gettingDetailsofTheUser();
      if (userDetailsModel != null) {
        // log('loading1');
        emit(ProfileLoadedState(profile: userDetailsModel));
      } else {
        // log('loading2');
        emit(ProfileErrorState('User details not found '));
      }
    } on FirebaseException catch (e) {
      // if(e.toString()=='PathNotFoundException'){
      //   emit(ImageLoadError());
      // }
      // log(e.toString());
      emit(ProfileErrorState(e.toString()));
    }
  }

  // FutureOr<void> getusersposts(
  //     FetchUserPost event, Emitter<ProfilePageState> emit) async {
   
  // }
}
