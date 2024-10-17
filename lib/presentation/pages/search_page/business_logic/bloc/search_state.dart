part of 'search_bloc.dart';


class SearchState {}

final class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchErrorState extends SearchState {
  final String? error;

  SearchErrorState({this.error});
}

class SearchingState extends SearchState {
  final List<UserDetailsModel>? user;
  final List<PostWithUserDetailsModel>? postsWithUser;
  final bool? hasReachedLimit;

  SearchingState({this.postsWithUser, this.hasReachedLimit,this.user});

  SearchingState copywith({
    final List<UserDetailsModel>? user,
    List<PostWithUserDetailsModel>? postsWithUser,
    bool? hasReachedLimit,
  }) {
    return SearchingState(
      user: user?? this.user,
      postsWithUser: postsWithUser ?? this.postsWithUser,
      hasReachedLimit: hasReachedLimit ?? this.hasReachedLimit,
    );
  }

  List<Object?> get props => [postsWithUser, hasReachedLimit,user];
}
class SearchEmptyState extends SearchState{}