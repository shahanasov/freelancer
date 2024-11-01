import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/db/model/user_and_post_model.dart';
import 'package:freelance/presentation/pages/other_users_profile_page/business_logic/bloc/post_related_bloc.dart';
import 'package:freelance/presentation/pages/other_users_profile_page/others_profile_page.dart';
import 'package:freelance/theme/color.dart';

Widget showallUsersWidget(state, bool web) {
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: GridView.builder(
        itemCount: state.users.length,
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisCount: web? 2:4,
          crossAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              context
                  .read<PostRelatedBloc>()
                  .add(AllPostsFetchEvent(userId: state.users[index]!.id));
              if (userId != state.users[index]!.id) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OthersProfilePage(
                          userModel: PostWithUserDetailsModel(
                              postModel: PostModel(
                                  postDescription: '',
                                  likes: [],
                                  imagepathofPost: '',
                                  time: DateTime.now()),
                              userDetailsModel: state.users[index]!),
                        )));
              }
            },
            child: Card(
              child: Padding(
                padding: web? EdgeInsets.all(25):
                const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CircleAvatar(
                          backgroundColor: white,
                          radius: 30,
                          backgroundImage: state.users[index]!.profilePhoto !=
                                  null
                              ? NetworkImage(state.users[index]!.profilePhoto!)
                              : const AssetImage("assets/images/profilenew.jpg")
                                  as ImageProvider,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${state.users[index]!.firstName} ${state.users[index]!.lastName}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(state.users[index]!.jobTitle)
                  ],
                ),
              ),
            ),
          );
        }),
  );
}
