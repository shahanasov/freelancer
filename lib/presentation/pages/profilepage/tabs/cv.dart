import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/pages/profilepage/businesslogin/bloc/profile_page_bloc.dart';

class ResumeWidget extends StatelessWidget {
  const ResumeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        if (state is ProfileLoadedState) {
          final skill = state.profile.skills.join(',');
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Text(
                  //   'About',
                  //   style: TextStyle(
                  //       decoration: TextDecoration.underline, fontSize: 20),
                  // ),
                  // Text(state.profile.firstName),
                  const Text(
                    'Personal Details',
                    style: TextStyle(
                        decoration: TextDecoration.underline, fontSize: 20),
                  ),
                  Text('Phone Number : ${state.profile.phone}',
                      style: const TextStyle(fontSize: 18)),
                  Text('Dob : ${state.profile.dob}',
                      style: const TextStyle(fontSize: 18)),
                  Text('Gender : ${state.profile.gender}',
                      style: const TextStyle(fontSize: 18)),
                  Text(
                      'Address : ${state.profile.city}\n ${state.profile.state}\n${state.profile.country}',
                      style: const TextStyle(fontSize: 18)),
                  const Text(
                    'Skills',
                    style: TextStyle(
                        decoration: TextDecoration.underline, fontSize: 20),
                  ),
                  Text(
                   skill,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ]),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
