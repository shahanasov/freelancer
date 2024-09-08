import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/model/userdetails.dart';
import 'package:freelance/presentation/login/login.dart';
import 'package:freelance/presentation/login/widgets/bloc/toggle_bloc.dart';
import 'package:freelance/theme/color.dart';

import 'profilepagebody.dart';

class ProfilePageAppBar extends StatelessWidget {
  final UserDetailsModel? userDetailsModel;

  const ProfilePageAppBar({
    super.key,
    this.userDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser;
    // context.read<ProfilePageBloc>().add(ProfileLoadEvent());
    return SafeArea(
      child: Scaffold(
          endDrawer: Drawer(
            child: BlocListener<ToggleBloc, ToggleState>(
              listener: (context, state) {
                if (state is SignOutState) {
                  Navigator.pop(context);
                  //have to check once more

                  // Navigator.of(context).pushReplacement(
                  //         MaterialPageRoute(
                  //             builder: (context) => const LoginPage()),);
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
                              title: const Text('Do you wana log out'),
                              actions: [
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
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //     builder: (context) =>  BuildProfile()));
                    },
                    child: const ListTile(
                      title: Text('Edit Your profile'),
                    ),
                  )
                ],
              ),
            ),
          ),
          drawerEnableOpenDragGesture: false,
          appBar: PreferredSize(
              preferredSize: const Size(double.infinity, 390),
              child: AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: Stack(
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
                          userDetailsModel != null
                              ? "${userDetailsModel?.firstName} ${userDetailsModel?.lastName}"
                              : '',
                          style: const TextStyle(fontSize: 30),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: Text(
                            userDetailsModel?.jobTitle ?? '',
                            // overflow: TextOverflow.ellipsis,
                            // maxLines: 5,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )),
          body: const ProfilePageBody()),
    );
  }
}
