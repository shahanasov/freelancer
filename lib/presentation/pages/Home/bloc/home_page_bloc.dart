import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelance/db/model/user_and_post_model.dart';
import 'package:freelance/db/services/post_functions.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageEvent>((event, emit) {});
    on<UsersPostFetchEvent>(fetchAllPost);
  }

  FutureOr<void> fetchAllPost(
      UsersPostFetchEvent event, Emitter<HomePageState> emit) async {
    try {
      emit(HomePageLoading());
      final postModel = await PostFunctions().fetchPostAlongwithUser();
      
        emit(HomePageLoaded(posts:postModel ));
      
    } on FirebaseException catch (e) {
      emit(HomePageError(error: e.message.toString()));
    }
  }
}
