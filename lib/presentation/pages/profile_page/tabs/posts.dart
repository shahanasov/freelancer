import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                return  Divider(
                  thickness: 1,
                  color: black,
                );
              },
                padding: const EdgeInsets.all(15),
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                          title: Text(state.posts[index].postDescription ?? ''),
                          subtitle: state.posts[index].imagepathofPost != null
                              ? Image.network(
                                  state.posts[index].imagepathofPost!,
                                  fit: BoxFit.cover,
                                )
                              : const SizedBox()),
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
                    ],
                  );
                });
          } else if (state is PostErrorState) {
            return Center(child: Text(state.error ?? '....'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
