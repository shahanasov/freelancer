import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/model/userdetails.dart';
import 'package:freelance/presentation/login/login.dart';
import 'package:freelance/presentation/login/widgets/bloc/toggle_bloc.dart';
import 'package:freelance/presentation/pages/profilepage/widgets/profilepagebody.dart';
import 'package:freelance/theme/color.dart';

class ProfilePageAppBar extends StatelessWidget {
  final UserDetailsModel? userDetailsModel;
  const ProfilePageAppBar({
    super.key,
    this.userDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Scaffold(
          endDrawer: Drawer(
            child: BlocListener<ToggleBloc, ToggleState>(
              listener: (context, state) {
                if (state is SignOutState) {
                  Navigator.pop(context);
                }
              },
              child: ListView(
                children: [
                  InkWell(
                    onTap: () {
                      context.read<ToggleBloc>().add(SignOut());
                    },
                    child: const ListTile(
                      title: Text('log out'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.read<ToggleBloc>().add(SignOut());
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginPage()));
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
                          userDetailsModel!=null?
                          "${userDetailsModel?.firstName} ${userDetailsModel?.lastName}":'name',
                          style: const TextStyle(fontSize: 30),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: Text(
                            userDetailsModel?.description ?? 'Description',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
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
