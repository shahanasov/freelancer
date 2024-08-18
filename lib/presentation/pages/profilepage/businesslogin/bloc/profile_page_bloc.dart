import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freelance/db/functions/firebaseauth.dart';
import 'package:freelance/db/model/userdetails.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  final Authentication auth;
  ProfilePageBloc({required this.auth}) : super(ProfilePageInitial()) {
    on<ProfilePageEvent>((event, emit) {});
    on<ProfileLoadEvent>(getuserDetails);
  }

Future<void> getuserDetails(
  ProfileLoadEvent event, Emitter<ProfilePageState> emit) async {
    
  emit(ProfileLoadingState());
  try {
    final UserDetailsModel? userDetailsModel = await auth.gettingDetailsofTheUser();
    if (userDetailsModel != null) {
      emit(ProfileLoadedState(profile: userDetailsModel));
    } else {
      emit(ProfileErrorState('User details not found '));
    }
  } catch (e) {
    emit(ProfileErrorState(e.toString()));
  }
}

}
