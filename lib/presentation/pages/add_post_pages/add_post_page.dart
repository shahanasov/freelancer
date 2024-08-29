import 'package:flutter/material.dart';

class PostAddPage extends StatelessWidget {
  const PostAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const Icon(Icons.close),
        actions: [TextButton(onPressed: () {}, child: const Text('Next'))],
      ),
      body: const Padding(
        padding: EdgeInsets.all(10.0),
        child: TextField(
          maxLines: 100,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Share your thoughts....' 
          ),
        ),
      ),
      floatingActionButton: const Icon(Icons.add_a_photo),
    );
  }
}
