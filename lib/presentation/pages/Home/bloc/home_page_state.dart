part of 'home_page_bloc.dart';

 class HomePageState {}

final class HomePageInitial extends HomePageState {}
class HomePageLoading extends HomePageState{}
class HomePageLoaded extends HomePageState{
 final List<PostWithUserDetailsModel> posts;
  HomePageLoaded({required this.posts,});
}
class HomePageError extends HomePageState{
  String? error;
  HomePageError({this.error});
}
