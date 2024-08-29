import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';

class PostsWidget extends StatelessWidget {
  const PostsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: 10,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
              crossAxisCount: 3),
          itemBuilder: (context ,index){
            return Container(height: 50,color: white,);
          }),
    );
  }
}
