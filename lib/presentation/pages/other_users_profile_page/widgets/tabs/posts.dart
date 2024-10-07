import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/db/services/post_functions.dart';
import 'package:freelance/presentation/pages/edit_post/edit_post.dart';
import 'package:freelance/presentation/pages/profile_page/businesslogin/bloc/profile_page_bloc.dart';
import 'package:freelance/theme/color.dart';
import 'package:intl/intl.dart';

class PostsWidget extends StatelessWidget {
  final List<PostModel> postModelList;
  const PostsWidget({super.key, required this.postModelList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 1,
              color: black,
            );
          },
          padding: const EdgeInsets.all(15),
          itemCount: postModelList.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                    title: Text(
                      DateFormat('MM/dd/yyyy')
                          .format(postModelList[index].time),
                    ),
                    trailing: FirebaseAuth.instance.currentUser!.uid !=
                            postModelList[index].userId
                        ? const SizedBox()
                        : IconButton(
                            onPressed: () {
                              showBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditPost(
                                                            postModel:
                                                                postModelList[
                                                                    index])));
                                          },
                                          leading: const Icon(Icons.edit),
                                          title: const Text('Edit Post'),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Do you wanna delete the post'),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                              'Cancel')),
                                                      TextButton(
                                                          onPressed: () {
                                                            PostFunctions()
                                                                .deletePost(
                                                                    postModelList[
                                                                        index]);
                                                            context
                                                                .read<
                                                                    ProfilePageBloc>()
                                                                .add(
                                                                    PostEditEvent());
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                              'Delete'))
                                                    ],
                                                  );
                                                });
                                          },
                                          leading: const Icon(Icons.delete),
                                          title: const Text('Delete this Post'),
                                        )
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(Icons.more_vert))),
                ListTile(
                  title: Text(postModelList[index].postDescription ?? ''),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    child: postModelList[index].imagepathofPost != null
                        ? Image.network(
                            postModelList[index].imagepathofPost!,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox()),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Icon(Icons.favorite),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.share),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.add)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("${postModelList[index].likes.length} likes"),
              ],
            );
          }),
    );
  }
}
