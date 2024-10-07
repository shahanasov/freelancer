part of 'post_related_bloc.dart';

 class PostRelatedEvent {}
  class AllPostsFetchEvent extends PostRelatedEvent{
  final String userId;

  AllPostsFetchEvent({required this.userId});
 }
 class PostLikeEvent extends PostRelatedEvent{}
