
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            return ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: ListTile(
                        title: Text(state.posts[index].postDescription ?? ''),
                        subtitle: state.posts[index].imagepathofPost != null
                            ? Image.network(
                                state.posts[index].imagepathofPost!,
                                // height: 100,
                                fit: BoxFit.cover,
                              )
                            : const SizedBox()),
                  );
                  // }
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
