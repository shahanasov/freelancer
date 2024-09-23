import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/services/post_functions.dart';
import 'package:freelance/presentation/pages/edit_post/edit_post.dart';
import 'package:freelance/theme/color.dart';

import 'bloc/tabs_bloc.dart';

class PostsWidget extends StatelessWidget {
  const PostsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<TabsBloc, TabsState>(
        builder: (context, state) {
          // print(state.toString());
          if (state is PostLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostTabState) {
            return ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 1,
                    color: black,
                  );
                },
                padding: const EdgeInsets.all(15),
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                          title: Text(state.posts[index].postDescription ?? ''),
                          trailing: IconButton(
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
                                                                  state.posts[
                                                                      index])));
                                            },
                                            leading: const Icon(Icons.edit),
                                            title: const Text('Edit post'),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Do you want to delete this Post'),
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
                                                              // ProgressIndicatorTheme(data: , child: child)
                                                              Future.delayed(
                                                                  const Duration(
                                                                      seconds:
                                                                          2),
                                                                  () {
                                                                PostFunctions()
                                                                    .deletePost(
                                                                        state.posts[
                                                                            index]);
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(const SnackBar(
                                                                        content:
                                                                            Text('Post Deleted')));
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              });
                                                            },
                                                            child: const Text(
                                                                'Delete'))
                                                      ],
                                                    );
                                                  });
                                            },
                                            leading: const Icon(Icons.delete),
                                            title: const Text('Delete'),
                                          )
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(Icons.more_vert))),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          child: state.posts[index].imagepathofPost != null
                              ? Image.network(
                                  state.posts[index].imagepathofPost!,
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
                      Text("${state.posts[index].likes} likes"),
                    ],
                  );
                });
          } else if (state is PostErrorState) {
            return Center(child: Text(state.error ?? '....'));
          } else if (state is PostEmptyState) {
            return const Center(
              child: Text('No Posts available'),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
