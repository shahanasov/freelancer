import 'package:flutter/material.dart';
import 'package:freelance/presentation/pages/profilepage/widgets/tabcontainer.dart';

class ProfilePageBody extends StatelessWidget {
  const ProfilePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(children: [
        Divider(
          thickness: 3,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TabContainer(
              tabtext: 'Posts',
            ),
            TabContainer(
              tabtext: 'Resume',
            ),
            TabContainer(
              tabtext: 'Works',
            )
          ],
        )
      ]),
    );
  }
}
