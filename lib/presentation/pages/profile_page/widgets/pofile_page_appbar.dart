import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/db/model/user_details.dart';
import 'package:freelance/presentation/build_profile_page/buildprofile/buildprofile.dart';
import 'package:freelance/presentation/login_page/login_page.dart';
import 'package:freelance/presentation/login_page/widgets/bloc/toggle_bloc.dart';
import 'package:freelance/presentation/pages/add_post_page/add_post_page.dart';
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
                //have to check once more
              }
            },
            child: ListView(
              children: [
                const DrawerHeader(child:Text('Others')),
                InkWell(
                  onTap: () {
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
                                      Navigator.of(context).pushReplacement(
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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
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
        //! everywhere
        floatingActionButton: const AddPostButton(),
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
                        Text(userDetailsModel == null
                            ? ''
                            : '${userDetailsModel?.follow.length} followers')
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
