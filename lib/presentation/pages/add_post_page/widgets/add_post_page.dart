import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/presentation/pages/add_post_page/bloc/add_post_bloc.dart';
import 'package:freelance/presentation/pages/add_post_page/widgets/add_widget.dart';
import 'package:freelance/presentation/pages/add_post_page/share_thoughts_widget.dart';

class PostAddWidget extends StatelessWidget {
  PostAddWidget({super.key});

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
                onPressed: () {
                  context.read<AddPostBloc>().add(CloseImage());
                  Navigator.of(context).pop();
                },
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
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: AddPostPage(
                          sharethoughtsController: sharethoughtsController,
                        ),
                      )),
          );
        } else if (state is EditingState) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      final postDescription =
                          sharethoughtsController.text.trim();
                      if (postDescription.isNotEmpty) {
                        final postModel = PostModel(
                          time: DateTime.now(),
                          likes: [],
                          postDescription: postDescription,
                          imagepathofPost: state.editedImage.path,
                        );

                        context
                            .read<AddPostBloc>()
                            .add(UploadEvent(postModel: postModel));
                      } else {
                        Navigator.of(context).pop();
                      }

                      Navigator.of(context).pop();
                      sharethoughtsController.clear();
                    },
                    child: const Text('Done'))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
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
            ),
          );
        } else if (state is UploadLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const EditImageWidget();
        }
      },
    );
  }
}
