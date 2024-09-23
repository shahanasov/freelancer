import 'package:flutter/material.dart';
import 'package:freelance/db/model/user_and_post_model.dart';
import 'package:freelance/presentation/pages/message_page/chat/personal_chat.dart';
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
          body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: true,
            expandedHeight: 350,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    color: black,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CircleAvatar(
                              radius: 60,
                              child: Image.asset(
                                "assets/images/profilenew.jpg",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
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
                          // overflow: TextOverflow.ellipsis,
                          // maxLines: 5,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChatPage(
                                    recieverEmail: userModel.postModel.userId!, recieverId: userModel.postModel.userId!, user: userModel.userDetailsModel,)));
                          },
                          child: const TabContainer(tabtext: 'Message'))
                    ],
                  )
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
        ],
      )),
    );
  }
}
