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
      builder: (context, state) {
        if (state is ProfilePageInitial) {
          return Container(color: Colors.red,);
        } else if (state is ProfileLoadedState) {
          return ProfilePageAppBar(userDetailsModel: state.profile);
        } else if(state is ProfileErrorState){
          return Container(color: Colors.blueGrey, child: Center(
            child: Text(state.message),
          ),);
        }else{
          return Container(color: Colors.amberAccent,);
         
        }
      },
    );
  }
}
