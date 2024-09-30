import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/model/user_details.dart';
import 'package:freelance/presentation/login_page/login_page.dart';
import 'package:freelance/presentation/login_page/widgets/bloc/toggle_bloc.dart';
import 'package:freelance/presentation/pages/profile_page/widgets/profile_page_resume_post.dart';
import 'package:freelance/presentation/pages/profile_page/widgets/tab_container.dart';
import 'package:freelance/theme/color.dart';

class ProfilePageAppBar extends StatelessWidget {
  final UserDetailsModel? userDetailsModel;

  const ProfilePageAppBar({
    super.key,
    this.userDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    // if (userDetailsModel != null) {
    //   context
    //       .read<ProfilePageBloc>()
    //       .add(PostLoadEvent(id: userDetailsModel!.id));
    // }
    return SafeArea(
      child: Scaffold(
          endDrawer: Drawer(
            child: BlocListener<ToggleBloc, ToggleState>(
              listener: (context, state) {
                if (state is SignOutState) {
                  Navigator.pop(context);
                  //have to check once more
                }
              },
              child: ListView(
                children: [
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
                    onTap: (){
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //     builder: (context) =>  BuildProfile()));
                    },
                    title: const Text('Edit Your profile'),
                  ),
                  ListTile(
                    onTap: () {
                      
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
                          Text(userDetailsModel==null ?'':
                            '${userDetailsModel?.follow.length} followers')
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
                    : UserDetailedProfile(userModel: userDetailsModel!),
              )
            ],
          )),
    );
  }
}