import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelance/db/services/firebase_auth.dart';
import 'package:freelance/db/services/firebase_database.dart';
import 'package:freelance/db/model/user_details.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  final UserDatabaseFunctions storage;
  final Authentication auth;
  ProfilePageBloc({required this.storage, required this.auth})
      : super(ProfilePageInitial()) {
    on<ProfilePageEvent>((event, emit) {});

    on<ProfileLoadEvent>(getuserDetails);
  }

  Future<void> getuserDetails(
      ProfileLoadEvent event, Emitter<ProfilePageState> emit) async {
    try {
      emit(ProfileLoadingState());
      final UserDetailsModel? userDetailsModel =
          await storage.gettingDetailsOfTheUser();
      if (userDetailsModel != null) {
        emit(ProfileLoadedState(profile: userDetailsModel));
      } else {
        emit(ProfileErrorState('User details not found '));
      }
    } on FirebaseException catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }
}
