import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
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
  }

  FutureOr<void> selectImage(
      AddPostEvent event, Emitter<AddPostState> emit) async {
    if (event is SelectImage) {
      try {
        final XFile? image = await PostFunctions().imageSelect();
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
      final Uint8List? editedImage = await Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => ImageEditor(
            image: event.image, // <-- Uint8List of image
          ),
        ),
      );
      if (editedImage != null) {
        final editedImageFile =
            await PostFunctions().convertUint8ListToFile(editedImage);
        emit(EditingState(editedImage: editedImageFile));
      }
    } catch (e) {
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
}
