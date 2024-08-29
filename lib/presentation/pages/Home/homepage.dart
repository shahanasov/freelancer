import 'package:flutter/material.dart';
import 'package:freelance/presentation/pages/Home/widgets/post_widget.dart';
import 'package:freelance/presentation/pages/message_page/message_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
            appBar: AppBar(
              toolbarOpacity: 1,
              title: const Text('SkillVerse'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.message),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ListMessagePage()));
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      children: postWidget
                    );
                  }),
            )));
  }
}
