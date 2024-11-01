  import 'package:flutter/material.dart';
import 'package:freelance/presentation/pages/message_page/message_list.dart';
import 'package:freelance/presentation/pages/profile_page/widgets/add_post_button.dart';

AppBar customAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarOpacity: 1,
      title: const Text('HireArti'),
      actions: [
        const AddPostButton(),
        IconButton(
          icon: const Icon(Icons.message),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ChatListPage()),
            );
          },
        ),
        const SizedBox(width: 20),
      ],
    );
  }
