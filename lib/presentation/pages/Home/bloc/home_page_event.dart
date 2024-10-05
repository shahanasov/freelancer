part of 'home_page_bloc.dart';

class HomePageEvent {}

class UsersPostFetchEvent extends HomePageEvent {
  final String? userId;

  UsersPostFetchEvent({this.userId});
}

class AllPostofTheUserFetchEvent extends HomePageEvent {}
