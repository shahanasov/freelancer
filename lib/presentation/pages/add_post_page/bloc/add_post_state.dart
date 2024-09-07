part of 'add_post_bloc.dart';

 class AddPostState {}

final class AddPostInitial extends AddPostState {}
class ImageSelected extends AddPostState{
  final  XFile? selectedImage;
  ImageSelected({required this.selectedImage});
}
class EditingState extends AddPostState{
  final File editedImage;
  EditingState({required this.editedImage});
}
class UploadLoadingState extends AddPostState{}

