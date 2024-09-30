part of 'profile_page_bloc.dart';

class ProfilePageEvent {}

class ProfileLoadEvent extends ProfilePageEvent {}

class PostLoadEvent extends ProfilePageEvent {
 final String id;

  PostLoadEvent({required this.id});
}
