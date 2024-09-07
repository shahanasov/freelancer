import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/pages/add_post_page/bloc/add_post_bloc.dart';

class Body extends StatelessWidget {
  TextEditingController sharethoughtsController;
   Body({super.key,required this.sharethoughtsController});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: sharethoughtsController,
          maxLines: 100,
          decoration: const InputDecoration(
              border: InputBorder.none, hintText: 'Share your thoughts....'),
        ),
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add_a_photo),
        onPressed: () {
          context.read<AddPostBloc>().add(SelectImage());
        },
      ),
    );
  }
}