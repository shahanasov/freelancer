import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
// import '';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freelance/db/functions/firebasedatabase.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  AddPostBloc() : super(AddPostInitial()) {
    on<SelectImage>(selectImage);
    on<EditImage>(editImage);
  }

  FutureOr<void> selectImage(
      AddPostEvent event, Emitter<AddPostState> emit) async {
    if (event is SelectImage) {
      try {
        final XFile? image = await UserDatabaseFunctions().imageSelect();
        emit(ImageSelected(selectedImage: image));
      } catch (e) {
        return;
      }
    }
  }

  Future editImage(EditImage event, Emitter<AddPostState> emit) async {
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
     if(editedImage!=null){
      final editedImageFile = await UserDatabaseFunctions(). convertUint8ListToFile(editedImage);
      emit(EditingState(editedImage: editedImageFile));
     }
      
    } catch (e) {
      // emit(AddPostError("Failed to edit image"));
      // print(e);
    }
  }
}