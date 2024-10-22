import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/db/model/user_and_post_model.dart';
import 'package:freelance/db/model/user_details.dart';
import 'package:freelance/presentation/pages/other_users_profile_page/business_logic/bloc/post_related_bloc.dart';
import 'package:freelance/presentation/pages/other_users_profile_page/others_profile_page.dart';
import 'package:freelance/theme/color.dart';

class FollowersList extends StatelessWidget {
  final List<UserDetailsModel?> users;
  const FollowersList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Followers'),),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          if (users[index] != null) {
            return GestureDetector(onTap: (){
                context.read<PostRelatedBloc>().add(AllPostsFetchEvent(userId: users[index]!.id));
            },
              child: listTile(
                users[index]!, context),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

Widget listTile(UserDetailsModel user, context) {
  return ListTile(
    onTap: () {
    

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OthersProfilePage(
                userModel: PostWithUserDetailsModel(
                    postModel: PostModel(
                        postDescription: '',
                        likes: [],
                        imagepathofPost: '',
                        time: DateTime.now()),
                    userDetailsModel: user),
              )));
    },
    leading: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CircleAvatar(
          backgroundColor: white,
          radius: 20,
          backgroundImage: user.profilePhoto != null
              ? NetworkImage(user.profilePhoto!)
              : const AssetImage("assets/images/profilenew.jpg")
                  as ImageProvider,
        )),
    title: Text("${user.firstName} ${user.lastName}"),
    subtitle: Text(user.jobTitle),
  );
}
