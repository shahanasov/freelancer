import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/pages/profilepage/tabs/bloc/tabs_bloc.dart';
import 'package:freelance/presentation/pages/profilepage/tabs/posts.dart';
import 'package:freelance/presentation/pages/profilepage/tabs/works.dart';
import 'package:freelance/presentation/pages/profilepage/widgets/tabcontainer.dart';
import '../tabs/cv.dart';

class ProfilePageBody extends StatelessWidget {
  const ProfilePageBody({super.key});

  @override
  Widget build(BuildContext context) {
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
          } else {
            return const PostsWidget();
          }
        },
      )
    ]);
  }
}
