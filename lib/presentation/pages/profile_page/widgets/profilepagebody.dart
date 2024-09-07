import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../tabs/bloc/tabs_bloc.dart';
import '../tabs/cv.dart';
import '../tabs/posts.dart';
import '../tabs/works.dart';
import 'tabcontainer.dart';

class ProfilePageBody extends StatelessWidget {
  const ProfilePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<ProfilePageBloc>().add(ProfileLoadEvent());
    return Column(mainAxisSize: MainAxisSize.min, children: [
      const Divider(
        thickness: 3,
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              context.read<TabsBloc>().add(PostTabEvent());
              // final userId = FirebaseAuth.instance.currentUser?.uid;
              // if (userId != null) {
              //   context
              //       .read<ProfilePageBloc>()
              //       .add(FetchUserPost(userId: userId));
              // }
            },
            child: const TabContainer(
              tabtext: 'Posts',
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<TabsBloc>().add(ResumeTabEvent());
            },
            child: const TabContainer(
              tabtext: 'Resume',
            ),
          ),
          GestureDetector(
            onTap: () {
              // print('workstab');
              context.read<TabsBloc>().add(WorksTabEvent());
            },
            child: const TabContainer(
              tabtext: 'Works',
            ),
          )
        ],
      ),
      BlocBuilder<TabsBloc, TabsState>(
        builder: (context, state) {
          if (state is WorkTabState) {
            return const WorksWidget();
          } else if (state is ResumeTabState) {
            return const ResumeWidget();
          } else if (state is PostTabState) {
            return const PostsWidget(
            );
          } else {
            return const PostsWidget();
          }
        },
      )
    ]);
  }
}
