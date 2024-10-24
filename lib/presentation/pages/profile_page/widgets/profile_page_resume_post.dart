import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/db/model/user_details.dart';
import 'package:freelance/presentation/pages/other_users_profile_page/widgets/tabs/posts.dart';
import 'package:freelance/presentation/pages/resume_page/bloc/resume_pdf_bloc.dart';
import 'package:freelance/presentation/pages/resume_page/resume_detailed_page.dart';
import 'package:freelance/presentation/widgets/empty_post.dart';

class UserDetailedProfile extends StatelessWidget {
  final UserDetailsModel userModel;
  final List<PostModel>? posts;
  const UserDetailedProfile({super.key, required this.userModel, this.posts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(
          thickness: 3,
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          isThreeLine: true,
          title: const Text('Resume',
              style: TextStyle(
                  decoration: TextDecoration.underline, fontSize: 25)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${userModel.firstName} ${userModel.lastName}'),
              Row(
                children: [
                  Text('${userModel.gender} '),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        context.read<ResumePdfBloc>().add(ResumePdfFetch(
                            userId: FirebaseAuth.instance.currentUser!.uid));
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ResumePage(
                                  userDetails: userModel,
                                  userId:
                                      FirebaseAuth.instance.currentUser!.uid,
                                )));
                      },
                      child: const Text(
                        'read more....',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 3,
        ),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text('Posts',
              style: TextStyle(
                  decoration: TextDecoration.underline, fontSize: 25)),
        ),
        posts == null
            ? postEmpty(context)
            : PostsWidget(
                userDetailsModel: userModel,
                postModelList: posts!,
              )
      ],
    );
  }
}


