part of 'suggestions_widget_bloc.dart';

class SuggestionsWidgetState {}

final class SuggestionsWidgetInitial extends SuggestionsWidgetState {}
final class AllUsersDataLoaded extends SuggestionsWidgetState{
  final List<UserDetailsModel?> users;

  AllUsersDataLoaded({required this.users});
}
class UsersEmptyState extends SuggestionsWidgetState{}
class UserDetailsLoading extends SuggestionsWidgetState{}
