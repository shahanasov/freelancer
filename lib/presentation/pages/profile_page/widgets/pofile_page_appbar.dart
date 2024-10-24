import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/db/model/user_details.dart';
import 'package:freelance/db/services/firebase_database_usersaving_functions.dart';
import 'package:freelance/presentation/build_profile_page/buildprofile/buildprofile.dart';
import 'package:freelance/presentation/login_page/login_page.dart';
import 'package:freelance/presentation/login_page/widgets/bloc/toggle_bloc.dart';
import 'package:freelance/presentation/pages/other_users_profile_page/widgets/followers_list.dart';
import 'package:freelance/presentation/pages/profile_page/widgets/add_post_button.dart';
import 'package:freelance/presentation/pages/profile_page/widgets/profile_page_resume_post.dart';
import 'package:freelance/presentation/pages/settings_page/settings_page.dart';
import 'package:freelance/theme/color.dart';

class ProfilePageAppBar extends StatelessWidget {
  final UserDetailsModel? userDetailsModel;
  final List<PostModel>? posts;
  const ProfilePageAppBar({
    super.key,
    this.posts,
    this.userDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: BlocListener<ToggleBloc, ToggleState>(
            listener: (context, state) {
              if (state is SignOutState) {
                Navigator.pop(context);
              }
            },
            child: ListView(
              children: [
                const DrawerHeader(
                    child: Center(
                  child: Text(
                    'SkillVerse',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                )),
                InkWell(
                  onTap: () {
                    final navigatorContext = Navigator.of(context);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Do you wanna log out'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel')),
                              TextButton(
                                  onPressed: () {
                                    context.read<ToggleBloc>().add(SignOut());
                                    // ProgressIndicatorTheme(data: , child: child)
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      navigatorContext.pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()),
                                      );
                                    });
                                  },
                                  child: const Text('Log out'))
                            ],
                          );
                        });
                  },
                  child: const ListTile(
                    title: Text('log out'),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BuildProfile(
                              userDetailsModel: userDetailsModel,
                            )));
                  },
                  title: const Text('Edit Your profile'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
                  },
                  title: const Text('Settings'),
                )
              ],
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              actions: const [AddPostButton()],
              // title: Text("${userDetailsModel!.firstName} ${userDetailsModel!.lastName}"),
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
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: ClipRRect(
                                          borderRadius:  BorderRadius.circular(15),
                                          child: userDetailsModel != null &&
                                                  userDetailsModel!
                                                          .profilePhoto !=
                                                      null
                                              ? Image.network(userDetailsModel!
                                                  .profilePhoto!)
                                              : Image.asset(
                                                  "assets/images/profilenew.jpg"),
                                        ),
                                      );
                                    });
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage: userDetailsModel != null &&
                                            userDetailsModel!.profilePhoto !=
                                                null
                                        ? NetworkImage(
                                            userDetailsModel!.profilePhoto!)
                                        : const AssetImage(
                                                "assets/images/profilenew.jpg")
                                            as ImageProvider,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        userDetailsModel == null
                            ? const Text('')
                            : Text(
                                "${userDetailsModel!.firstName} ${userDetailsModel!.lastName}",
                                style: const TextStyle(fontSize: 30),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: userDetailsModel == null
                              ? const Text('')
                              : Text(
                                  userDetailsModel!.jobTitle,
                                  // overflow: TextOverflow.ellipsis,
                                  // maxLines: 5,
                                  textAlign: TextAlign.center,
                                ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final navigatorContext = Navigator.of(context);
                            List<UserDetailsModel?> followers =
                                await UserDatabaseFunctions().followersList();
                            navigatorContext.push(MaterialPageRoute(
                                builder: (context) =>
                                    FollowersList(users: followers)));
                          },
                          child: Text(userDetailsModel == null
                              ? ''
                              : '${userDetailsModel?.follow.length} followers'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              // here body of profilepage
              child: userDetailsModel == null
                  ? Container()
                  : UserDetailedProfile(
                      userModel: userDetailsModel!,
                      posts: posts,
                    ),
            )
          ],
        ));
  }
}
