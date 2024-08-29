import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/pages/add_post_pages/bloc/add_post_bloc.dart';
import 'package:image_editor_plus/image_editor_plus.dart';

class PostAddPage extends StatelessWidget {
  const PostAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPostBloc, AddPostState>(
      builder: (context, state) {
        if (state is AddPostInitial) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: const Icon(Icons.close),
              actions: [
                TextButton(onPressed: () {}, child: const Text('Next'))
              ],
            ),
            body: const Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                maxLines: 100,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Share your thoughts....'),
              ),
            ),
            floatingActionButton: IconButton(
              icon: const Icon(Icons.add_a_photo),
              onPressed: () {
                context.read<AddPostBloc>().add(SelectImage());
              },
            ),
          );
        } else if (state is ImageSelected) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {},
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      context.read<AddPostBloc>().add(EditImage(
                          image: File(state.selectedImage!.path),
                          context: context));
                    },
                    child: const Text('Next'))
              ],
            ),
            body: Center(
              child: state.selectedImage != null
                  ? Image.file(File(state.selectedImage!.path))
                  : Container(),
            ),
          );
        } else if (state is EditingState) {
          return Scaffold(appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {},
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      
                    },
                    child: const Text('Next'))
              ],
            ),
            body: Center(child: Image.file(File(state.editedImage.path))),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: const Icon(Icons.close),
              actions: [
                TextButton(onPressed: () {}, child: const Text('Next'))
              ],
            ),
            body: const Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                maxLines: 100,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Share your thoughts....'),
              ),
            ),
            floatingActionButton: IconButton(
              icon: const Icon(Icons.add_a_photo),
              onPressed: () {
                context.read<AddPostBloc>().add(SelectImage());
              },
            ),
          );
        }
      },
    );
  }
}
