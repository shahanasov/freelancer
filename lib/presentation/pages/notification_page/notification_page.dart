import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/pages/message_page/message_list.dart';
import 'package:freelance/presentation/pages/notification_page/bloc/notification_bloc.dart';
import 'package:freelance/presentation/pages/other_users_profile_page/widgets/follow.dart';
import 'package:freelance/presentation/pages/profile_page/widgets/add_post_button.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NotificationBloc>().add(NotificationFetch());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarOpacity: 1,
        title: const Text('SkillVerse'),
        actions: [
          const AddPostButton(),
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ChatListPage(),
                ),
              );
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          // print(state.toString());

          if (state is NotificationLoaded) {
            // Handle empty notifications early
            // print(state.user.length);
            if (state.user.isEmpty) {
              return const Center(
                child: Text('No Notifications'),
              );
            }

            // If notifications exist, build the list
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: state.user.length,
                itemBuilder: (context, index) {
                  final user = state.user[index];
                  if (user == null) {
                    return Container(); // Handle the case where the user is null
                  }
                  return Card(
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: state.user[index]!.profilePhoto != null
                            ? CircleAvatar(
                                radius: 20,
                                child: Image.network(
                                    state.user[index]!.profilePhoto!),
                              )
                            : CircleAvatar(
                                radius: 20,
                                child: Image.asset(
                                  "assets/images/profilenew.jpg",
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                      ),
                      title:
                          Text("${user.firstName} is started following you "),
                      trailing: FollowButton(
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          isfollowed: state.user[index]!.follow.contains(
                              FirebaseAuth.instance.currentUser!.uid)),
                    ),
                  );
                },
              ),
            );
          } else if (state is NotificationLoading) {
            // Center the loading spinner
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // Default state when there's no data or an error occurred
            return Container(
              color: const Color.fromARGB(255, 54, 53, 53),
            );
          }
        },
      ),
    );
  }
}
