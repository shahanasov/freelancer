import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/db/services/post_functions.dart';


part 'post_related_event.dart';
part 'post_related_state.dart';

class PostRelatedBloc extends Bloc<PostRelatedEvent, PostRelatedState> {
  PostRelatedBloc() : super(PostRelatedInitial()) {
    on<PostRelatedEvent>((event, emit) {
    });
     on<AllPostsFetchEvent>(getAllPosts);
     on<PostLikeEvent>(likePost);
  }

  FutureOr<void> getAllPosts(AllPostsFetchEvent event, Emitter<PostRelatedState> emit)async {
    try {
      emit(PostLoadingState());
      List<PostModel> posts =
          await PostFunctions().getSpecificUserPosts(event.userId);
      emit(PostLoadedState(posts: posts));
    } catch (e) {
      (e);
    }
  }

  FutureOr<void> likePost(PostLikeEvent event, Emitter<PostRelatedState> emit) {
    
  }
}
