import 'package:flutter/material.dart';
import 'package:freelance/db/services/firebase_database_usersaving_functions.dart';
import 'package:freelance/presentation/pages/profile_page/widgets/tab_container.dart';

class FollowButton extends StatefulWidget {
  final String userId;
  final bool isfollowed;
  const FollowButton(
      {super.key, required this.userId, required this.isfollowed});

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  late bool isfollowed;
  @override
  void initState() {
    isfollowed = widget.isfollowed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            isfollowed = !isfollowed;
          });
          UserDatabaseFunctions().following(isfollowed, widget.userId);
          
        },
        child: isfollowed
            ? const TabContainer(tabtext: 'Followed')
            : const TabContainer(tabtext: 'Follow'));
  }
}
