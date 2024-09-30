import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/pages/profile_page/businesslogin/bloc/profile_page_bloc.dart';
import 'package:freelance/presentation/pages/profile_page/widgets/pofile_page_appbar.dart';

// import 'tabs/bloc/tabs_bloc.dart';

class ProfilePage extends StatelessWidget {
  final String? id;
  const ProfilePage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    context.read<ProfilePageBloc>().add(ProfileLoadEvent());
    // context.read<TabsBloc>().add(PostTabEvent());
    return BlocConsumer<ProfilePageBloc, ProfilePageState>(
      listener: (context, state) {},
      // buildWhen: (previous, current) => current is !PostTabState && current is !ResumeTabState && current is !WorkTabState,
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const ProfilePageAppBar();
        } else if (state is ProfileErrorState) {
          return const ProfilePageAppBar();
        } else if (state is ProfileLoadedState ) {
          return ProfilePageAppBar(userDetailsModel: state.profile);
        }else if( state is PostLoadedState){
          return const ProfilePageAppBar();
        } 
        else {
          return Container(
              // color: Colors.amberAccent,
              );
        }
      },
    );
  }
}
