import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/pages/profilepage/businesslogin/bloc/profile_page_bloc.dart';

class ResumeTabWidget extends StatelessWidget {
  const ResumeTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        if (state is ProfileLoadedState) {
          final skill = state.profile.skills.join(',');

          // Create a list of widgets to display each piece of information
          List<Widget> listItems = [
            const ListTile(title: Text('About', style: TextStyle(decoration: TextDecoration.underline, fontSize: 20))),
            ListTile(title: Text(state.profile.firstName)),
            const ListTile(title: Text('Personal Details', style: TextStyle(decoration: TextDecoration.underline, fontSize: 20))),
            ListTile(title: Text('Phone Number : ${state.profile.phone}', style: const TextStyle(fontSize: 18))),
            ListTile(title: Text('Dob : ${state.profile.dob}', style: const TextStyle(fontSize: 18))),
            ListTile(title: Text('Gender : ${state.profile.gender}', style: const TextStyle(fontSize: 18))),
            ListTile(title: Text('Address : \n${state.profile.city}\n${state.profile.state}\n${state.profile.country}', style: const TextStyle(fontSize: 18))),
            const ListTile(title: Text('Skills', style: TextStyle(decoration: TextDecoration.underline, fontSize: 20))),
            ListTile(title: Text(skill)),
            // You can add more ListTiles as needed
          ];

          // Return a SingleChildScrollView with a ListView to handle the dynamic content
          return SingleChildScrollView(
            child: ListView(children: listItems),
          );
        } else {
          return Container(); // Return an empty container if the state is not loaded
        }
      },
    );
  }
}
