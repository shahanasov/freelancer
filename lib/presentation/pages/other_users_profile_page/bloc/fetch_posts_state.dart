part of 'fetch_posts_bloc.dart';

class FetchPostsState {}

final class FetchPostsInitial extends FetchPostsState {}

final class PostLoadingState extends FetchPostsState {}

final class PostLoadedState extends FetchPostsState {
  final List<PostModel> posts;

  PostLoadedState({required this.posts});
}

final class PostEmptyState extends FetchPostsState{}