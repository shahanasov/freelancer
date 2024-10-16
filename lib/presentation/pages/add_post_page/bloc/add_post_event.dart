part of 'add_post_bloc.dart';

class AddPostEvent {}

class SelectImage extends AddPostEvent {}
class CloseImage extends AddPostEvent{}

class EditImage extends AddPostEvent {
  final File image;
  final BuildContext context;
  EditImage({
    required this.context,
    required this.image,
  });
}

class UploadEvent extends AddPostEvent{
  final PostModel postModel;

  UploadEvent({required this.postModel});
  
}

