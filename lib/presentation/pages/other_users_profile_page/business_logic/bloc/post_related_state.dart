part of 'post_related_bloc.dart';

 class PostRelatedState {}

final class PostRelatedInitial extends PostRelatedState {}
final class FetchPostsInitial extends PostRelatedState{}
final class PostLoadingState extends PostRelatedState{}
final class PostLoadedState extends PostRelatedState {
  final List<PostModel> posts;

  PostLoadedState({required this.posts});
}

final class PostEmptyState extends PostRelatedState{}