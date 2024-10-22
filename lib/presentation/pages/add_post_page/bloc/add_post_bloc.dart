import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/db/services/post_functions.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  AddPostBloc() : super(AddPostInitial()) {
    on<SelectImage>(selectImage);
    on<EditImage>(editImage);
    on<UploadEvent>(uploadpost);
    on<CloseImage>(closing);
  }

  FutureOr<void> selectImage(
      AddPostEvent event, Emitter<AddPostState> emit) async {
    if (event is SelectImage) {
      try {
        final XFile? image = await PostFunctions().imageSelect();
        // print(image!.name);
        emit(ImageSelected(selectedImage: image));
      } catch (e) {
        return;
      }
    }
  }

  Future editImage(EditImage event, Emitter<AddPostState> emit) async {
    emit(UploadLoadingState());
    try {
      // Pass the File directly to the ImageEditor
      var image=await event.image.readAsBytes();
      final  editedImage = await Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) {
            log('edited image');
            return ImageEditor(
            image: image, // <-- Uint8List of image
          );
          },
        ),
      );
      if (editedImage != null) {
        log(editedImage.runtimeType.toString());
        log(event.image.runtimeType.toString());
        final editedImageFile =
            await PostFunctions().convertUint8ListToFile(editedImage,image:event.image);

        emit(EditingState(editedImage: editedImageFile));
      }
    } catch (e) {
      log('error: $e');
      // emit(AddPostError("Failed to edit image"));
      // print(e);
    }
  }

  FutureOr<void> uploadpost(
      UploadEvent event, Emitter<AddPostState> emit) async {
        emit(UploadLoadingState());
    try {
      // final uploadedPostModel =
      await PostFunctions().uploadDescriptionAndImage(postModel: event.postModel);
      emit(AddPostInitial());
    } catch (e) {
      (e);
    }
  }

  FutureOr<void> closing(CloseImage event, Emitter<AddPostState> emit) {
    emit(AddPostInitial());
  }
}
