import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance/presentation/pages/notification_page/bloc/notification_bloc.dart';
import 'package:freelance/presentation/pages/other_users_profile_page/widgets/follow.dart';
import 'package:freelance/theme/color.dart';

Widget notificationWidget(NotificationLoaded state) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: ListView.builder(
      itemCount: state.user.length,
      itemBuilder: (context, index) {
        final user = state.user[index];
        if (user == null) {
          return Container(); 
        }
        return Card(
          child: ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CircleAvatar(
                  backgroundColor: white,
                  radius: 20,
                  backgroundImage:
                      user.profilePhoto !=
                              null
                          ? NetworkImage(user.profilePhoto!)
                          : const AssetImage("assets/images/profilenew.jpg")
                              as ImageProvider,
                )),
            title: Text("${user.firstName} is started following you "),
            trailing: FollowButton(
                userId: user.id,
                isfollowed: state.user[index]!.follow
                    .contains(FirebaseAuth.instance.currentUser!.uid)),
          ),
        );
      },
    ),
  );
}
