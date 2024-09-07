import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/db/services/post_functions.dart';
import 'package:freelance/presentation/pages/add_post_page/bloc/add_post_bloc.dart';
import 'package:freelance/presentation/pages/add_post_page/widgets/add_widget.dart';
import 'package:freelance/presentation/pages/add_post_page/widgets/share_thoughts_widget.dart';

class PostAddPage extends StatelessWidget {
  PostAddPage({super.key});

  final TextEditingController sharethoughtsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPostBloc, AddPostState>(
      builder: (context, state) {
        if (state is AddPostInitial) {
          return const EditImageWidget();
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
                    :  Body(sharethoughtsController: sharethoughtsController,)),
          );
        } else if (state is EditingState) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  // Navigator.pop(context);
                },
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      final postDescription =
                          sharethoughtsController.text.trim();
                      final postModel = PostModel(
                        time: DateTime.now(),
                        postDescription: postDescription,
                        imagepathofPost: state.editedImage.path,
                      );

                      try {
                        // final uploadedPostModel =
                        await PostFunctions()
                            .uploadDescriptionAndImage(postModel: postModel);

                        // if (uploadedPostModel != null) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //         content: Text('Post uploaded successfully!')),
                        //   );
                        // } else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //         content: Text('Error uploading post.')),
                        //   );
                        // }
                      } catch (e) {
                        print('Error uploading post: $e');
                      }
                    },
                    child: const Text('Next'))
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: sharethoughtsController,
                    maxLines: 10,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Share your thoughts....'),
                  ),
                  Center(
                      child: Image.file(
                    File(state.editedImage.path),
                    width: double.infinity,
                    height: 300,
                  )),
                ],
              ),
            ),
          );
        } else if (state is UploadLoadingState) {
          return const Center(child: LinearProgressIndicator());
        } else {
          return const EditImageWidget();
        }
      },
    );
  }
}
