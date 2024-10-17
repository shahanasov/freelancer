import 'package:flutter/material.dart';
import 'package:freelance/presentation/pages/add_post_page/widgets/add_post_page.dart';

class AddPostButton extends StatelessWidget {
  const AddPostButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      tooltip: 'Add new post',
      // backgroundColor: white,
      // foregroundColor: black,
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostAddWidget(),
            ));
      },
      // child: const Icon(Icons.add)
    );
  }
}
