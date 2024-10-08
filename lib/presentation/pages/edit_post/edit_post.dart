import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/db/services/post_functions.dart';
import 'package:freelance/presentation/pages/profile_page/businesslogin/bloc/profile_page_bloc.dart';
import 'package:freelance/theme/color.dart';

class EditPost extends StatelessWidget {
  final PostModel postModel;
  const EditPost({required this.postModel, super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController descriptionController =
        TextEditingController(text: postModel.postDescription);
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                final edited = descriptionController.text.trim();
                final editedPost = PostModel(
                    userId: postModel.userId,
                    postId: postModel.postId,
                    postDescription: edited,
                    likes: postModel.likes,
                    imagepathofPost: postModel.imagepathofPost,
                    time: postModel.time);
                // print(editedPost.postId);
                PostFunctions().editPost(editedPost);
                context.read<ProfilePageBloc>().add(PostEditEvent());
                Navigator.of(context).pop();
              },
              child: const Text('Done'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              minLines: 5,
              maxLines: 15,
              style: TextStyle(color: black),
              controller: descriptionController,
              decoration: InputDecoration(
                  focusColor: white,
                  filled: true,
                  fillColor: white,
                  hintText: 'Write a short description about you', //reached
                  hintStyle: TextStyle(color: hintcolor),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            )
          ],
        ),
      ),
    );
  }
}
