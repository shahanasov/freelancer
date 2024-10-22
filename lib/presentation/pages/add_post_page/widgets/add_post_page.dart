import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/presentation/bottom_navigation_main/bloc/bloc/bottomnavigation_bloc.dart';
import 'package:freelance/presentation/pages/add_post_page/bloc/add_post_bloc.dart';
import 'package:freelance/presentation/pages/add_post_page/widgets/add_widget.dart';
import 'package:freelance/presentation/pages/add_post_page/share_thoughts_widget.dart';
import 'package:freelance/presentation/pages/home/bloc/home_page_bloc.dart';

class PostAddWidget extends StatelessWidget {
  PostAddWidget({super.key});
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final TextEditingController sharethoughtsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPostBloc, AddPostState>(
      builder: (context, state) {
        if (state is AddPostInitial) {
          return EditImageWidget();
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
                          formKey: formkey,
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
                      if (formkey.currentState!.validate()) {
                        formkey.currentState!.save();
                        submit(context, state);
                      } else {
                        Navigator.of(context).pop();
                      }

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
                    Form(
                      key: formkey,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please try to write something to share';
                          }
                          return null;
                        },
                        controller: sharethoughtsController,
                        maxLines: 10,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Share your thoughts....'),
                      ),
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
          return EditImageWidget();
        }
      },
    );
  }

  submit(context, state) {
    final postDescription = sharethoughtsController.text.trim();
    if (postDescription.isNotEmpty) {
      final postModel = PostModel(
        time: DateTime.now(),
        likes: [],
        postDescription: postDescription,
        imagepathofPost: state.editedImage.path,
      );

      context.read<AddPostBloc>().add(UploadEvent(postModel: postModel));
      BlocProvider.of<BottomNavigationBloc>(context)
          .add(TabChange(tabIndex: 0));
    } else {
      BlocProvider.of<BottomNavigationBloc>(context)
          .add(TabChange(tabIndex: 0));
    }
    context.read<HomePageBloc>().add(UsersPostFetchEvent());
  }
}
