import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/pages/add_post_page/bloc/add_post_bloc.dart';

class AddPostPage extends StatelessWidget {
  final TextEditingController sharethoughtsController;
  final GlobalKey<FormState>  formKey;
  const AddPostPage({super.key, required this.sharethoughtsController,required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.trim().isEmpty){
                return 'Please try to write something to share';
              }
              return null;
            },
            controller: sharethoughtsController,
            maxLines: 100,
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: 'Share your thoughts....'),
          ),
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
