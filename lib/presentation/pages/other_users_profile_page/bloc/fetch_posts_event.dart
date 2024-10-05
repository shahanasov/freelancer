part of 'fetch_posts_bloc.dart';

 class FetchPostsEvent {}
 class FetchAllPostsEvent extends FetchPostsEvent{
  final String userId;

  FetchAllPostsEvent({required this.userId});
 }
