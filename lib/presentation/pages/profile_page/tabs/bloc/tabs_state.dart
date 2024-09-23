part of 'tabs_bloc.dart';

class TabsState {}

final class TabsInitial extends TabsState {}

class PostLoadingState extends TabsState {}

class PostErrorState extends TabsState {
  final String? error;

  PostErrorState(String string, {this.error});
}

class PostTabState extends TabsState {
  final List<PostModel> posts;

  PostTabState({required this.posts});
}
class PostEmptyState extends TabsState{}

class ResumeTabState extends TabsState {}

class WorkTabState extends TabsState {}
