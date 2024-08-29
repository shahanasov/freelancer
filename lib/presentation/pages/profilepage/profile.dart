import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/pages/profilepage/businesslogin/bloc/profile_page_bloc.dart';
import 'package:freelance/presentation/pages/profilepage/widgets/pofilepageappbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfilePageBloc>().add(ProfileLoadEvent());
    return BlocConsumer<ProfilePageBloc, ProfilePageState>(
      listener: (context, state) {},
      // buildWhen: (previous, current) => current is !PostTabState && current is !ResumeTabState && current is !WorkTabState,
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return Container(
            // color: Colors.red,
          );
        } else if (state is ProfileErrorState) {
          return const ProfilePageAppBar();
        } else if (state is ProfileLoadedState) {
          return ProfilePageAppBar(userDetailsModel: state.profile);
        } else {
          return Container(
            // color: Colors.amberAccent,
          );
        }
      },
    );
  }
}
