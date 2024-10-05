part of 'home_page_bloc.dart';

 class HomePageState {}

final class HomePageInitial extends HomePageState {}
class HomePageLoading extends HomePageState{}
class HomePageLoaded extends HomePageState{
 final List<PostWithUserDetailsModel> userandPost;
 final List<PostModel>? posts;
  HomePageLoaded({required this.userandPost,this.posts});
}
class HomePageError extends HomePageState{
  String? error;
  HomePageError({this.error});
}
// class PostLikeUpdatedState extends HomePageState{
//   final String postId;
//   final int likeCount;

//   PostLikeUpdatedState({required this.postId, required this.likeCount});
  
// }

