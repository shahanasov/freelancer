import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance/db/model/user_and_post_model.dart';
import 'package:freelance/db/model/user_details.dart';
import 'package:freelance/db/services/firebase_database_usersaving_functions.dart';
import 'package:freelance/presentation/pages/message_page/chat/personal_chat.dart';
import 'package:freelance/presentation/pages/other_users_profile_page/widgets/follow.dart';
import 'package:freelance/presentation/pages/other_users_profile_page/widgets/followers_list.dart';
import 'package:freelance/presentation/pages/other_users_profile_page/widgets/profile_body_scrollable.dart';
import 'package:freelance/presentation/pages/profile_page/widgets/tab_container.dart';
import 'package:freelance/theme/color.dart';

class OthersProfilePage extends StatelessWidget {
  final PostWithUserDetailsModel userModel;

  const OthersProfilePage({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: true,
          expandedHeight: 380,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  color: black,
                ),
                profileHeader(context)
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          //here body of profilepage
          child: ScrollableAppBar(
            userModel: userModel,
          ),
        )
      ])),
    );
  }

  Widget profileHeader(context) {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 80,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: userModel.userDetailsModel.profilePhoto != null
                              ? Image.network(
                                  userModel.userDetailsModel.profilePhoto!)
                              : Image.asset("assets/images/profilenew.jpg"),
                        ),
                      );
                    });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: userModel.userDetailsModel.profilePhoto !=
                          null
                      ? NetworkImage(userModel.userDetailsModel.profilePhoto!)
                      : const AssetImage("assets/images/profilenew.jpg")
                          as ImageProvider,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "${userModel.userDetailsModel.firstName} ${userModel.userDetailsModel.lastName}",
          style: const TextStyle(fontSize: 30),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Text(
            userModel.userDetailsModel.jobTitle,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FollowButton(
              userId: userModel.userDetailsModel.id,
              isfollowed: userModel.userDetailsModel.follow.contains(userId),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChatPage(
                            recieverEmail: userModel.userDetailsModel.id,
                            recieverId: userModel.userDetailsModel.id,
                            user: userModel.userDetailsModel,
                          )));
                },
                child: const TabContainer(tabtext: 'Message'))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () async {
            final navigatorContext = Navigator.of(context);
            List<UserDetailsModel?> followers =
                await UserDatabaseFunctions().followersList();

            navigatorContext.push(MaterialPageRoute(
                builder: (context) => FollowersList(users: followers)));
          },
          child: Text('${userModel.userDetailsModel.follow.length} followers'),
        )
      ],
    );
  }
}
