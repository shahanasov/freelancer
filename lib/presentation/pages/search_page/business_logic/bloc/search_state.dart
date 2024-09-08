part of 'search_bloc.dart';

class SearchState {}

final class SearchInitial extends SearchState {}

class SearchingState extends SearchState {
  final List<UserDetailsModel>? users;
  final bool? hasReachedLimit;

  SearchingState({this.users, this.hasReachedLimit}):super() ;
  SearchingState copywith({
  List<UserDetailsModel>? users,
  bool? hasReachedLimit,
  }){
    return SearchingState(
      users: users?? this.users,
      hasReachedLimit: hasReachedLimit?? this.hasReachedLimit,
    );
  }
  List<Object?> get props=>[users,hasReachedLimit];
}
class SearchResultLoaded extends SearchState {
  final List<UserDetailsModel>? users;
  final bool? hasReachedLimit;

 SearchResultLoaded({this.users, this.hasReachedLimit}):super();

  SearchResultLoaded copyWith({
    List<UserDetailsModel>? users,
    bool? hasReachedLimit,
  }) {
    return SearchResultLoaded(
      users: users ?? this.users,
      hasReachedLimit: hasReachedLimit ?? this.hasReachedLimit,
    );
  }

  @override
  List<Object?> get props => [users, hasReachedLimit];
}

