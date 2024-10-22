part of 'chatlist_bloc.dart';

 class ChatListState {}

final class ChatListInitial extends ChatListState {}
final class ChatListLoading extends ChatListState{}
final class ChatListed extends ChatListState{
  final List<UserDetailsModel> user;
 final List<Timestamp> time;
  ChatListed({required this.user, required this.time});
}
final class ChatListError extends ChatListState{
  final String error;

  ChatListError({required this.error});
}
