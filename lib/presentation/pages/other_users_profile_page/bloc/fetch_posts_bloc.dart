import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/db/services/post_functions.dart';

part 'fetch_posts_event.dart';
part 'fetch_posts_state.dart';

class FetchPostsBloc extends Bloc<FetchPostsEvent, FetchPostsState> {
  FetchPostsBloc() : super(FetchPostsInitial()) {
    on<FetchPostsEvent>((event, emit) {});
    on<FetchAllPostsEvent>(getAllPosts);
  }

  FutureOr<void> getAllPosts(
      FetchAllPostsEvent event, Emitter<FetchPostsState> emit) async {
    try {
      emit(PostLoadingState());
      List<PostModel> posts =
          await PostFunctions().getSpecificUserPosts(event.userId);
      emit(PostLoadedState(posts: posts));
    } catch (e) {
      (e);
    }
  }
}
