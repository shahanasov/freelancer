import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../theme/color.dart';
import '../businesslogin/bloc/profile_page_bloc.dart';

class ResumeWidget extends StatelessWidget {
  const ResumeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        if (state is ProfileLoadedState) {
          final skill = state.profile.skills.join(',');
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: white,
                  border: Border.all(color: black)),
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: white, border: Border.all(color: black)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About',
                            style: TextStyle(
                                color: black,
                                decoration: TextDecoration.underline,
                                fontSize: 20),
                          ),
                          Text(
                            state.profile.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: black, fontSize: 18),
                          ),
                          Text(
                            'Personal Details',
                            style: TextStyle(
                                color: black,
                                decoration: TextDecoration.underline,
                                fontSize: 20),
                          ),
                          Text(' ${state.profile.phone}',
                              style: TextStyle(color: black, fontSize: 18)),
                          Text(' ${state.profile.dob}',
                              style: TextStyle(
                                fontSize: 18,
                                color: black,
                              )),
                          Text(' ${state.profile.gender}',
                              style: TextStyle(color: black, fontSize: 18)),
                          Text(
                              ' ${state.profile.city}\n ${state.profile.state}\n${state.profile.country}',
                              style: TextStyle(
                                fontSize: 18,
                                color: black,
                              )),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Skills',
                            style: TextStyle(
                                color: black,
                                decoration: TextDecoration.underline,
                                fontSize: 20),
                          ),
                          Text(
                            skill,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: black,
                            ),
                          ),
                          Text(
                            'Services',
                            style: TextStyle(
                                color: black,
                                decoration: TextDecoration.underline,
                                fontSize: 20),
                          ),
                          Text(state.profile.services.join('\n *'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
