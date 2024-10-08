part of 'profile_page_bloc.dart';

class ProfilePageState {}

final class ProfilePageInitial extends ProfilePageState {}

class ProfileLoadingState extends ProfilePageState {}

class ProfileLoadedState extends ProfilePageState {
  final UserDetailsModel profile;

  ProfileLoadedState({required this.profile});
}

class ProfileErrorState extends ProfilePageState {
  final String message;

  ProfileErrorState(this.message);
}

class PostLoadingState extends ProfilePageState {}

class PostLoadedState extends ProfilePageState {
  final List<PostModel> post;
  final UserDetailsModel? profile;
  PostLoadedState({required this.post, this.profile});
}
