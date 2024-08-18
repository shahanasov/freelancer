import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/model/userdetails.dart';
import 'package:freelance/presentation/login/widgets/bloc/toggle_bloc.dart';
import 'package:freelance/presentation/pages/profilepage/widgets/profilepagebody.dart';
import 'package:freelance/theme/color.dart';

class ProfilePageAppBar extends StatelessWidget {
  final UserDetailsModel userDetailsModel;
  const ProfilePageAppBar({
    super.key, required this.userDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Scaffold(
        endDrawer: Drawer(
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
                  // context.read<ToggleBloc>().add(SignOut());
                },
                child: const ListTile(
                  title: Text('Edit Your profile'),
                ),
              )
            ],
      
          ),
        ),
        drawerEnableOpenDragGesture: false,
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 350),
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
                      const SizedBox(height: 110,),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 60,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(userDetailsModel.firstName,style: const TextStyle(fontSize: 30),),
                        const SizedBox(
                        height: 10,
                      ),
                      const Text('Position')
                    ],
                  ),
                ],
              ),
            )),
            body: const ProfilePageBody()
      ),
    );
  }
}

