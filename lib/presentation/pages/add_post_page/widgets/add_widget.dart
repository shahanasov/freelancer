import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/presentation/bottom_navigation_main/bloc/bloc/bottomnavigation_bloc.dart';
import 'package:freelance/presentation/pages/add_post_page/share_thoughts_widget.dart';
import 'package:freelance/presentation/pages/home/bloc/home_page_bloc.dart';
import '../../../../db/services/post_functions.dart';

class EditImageWidget extends StatelessWidget {
  EditImageWidget({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController sharethoughtsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close)),
          actions: [
            TextButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    submit(context);
                  } else {
                    Navigator.of(context).pop();
                  }
                 
                  sharethoughtsController.clear();
                },
                child: const Text('Done'))
          ],
        ),
        body: AddPostPage(
          formKey: formKey,
          sharethoughtsController: sharethoughtsController,
        ));
  }

  void submit(context) async {
    final postDescription = sharethoughtsController.text.trim();
    if (postDescription.isNotEmpty) {
      PostModel postModel = PostModel(
          likes: [],
          postDescription: postDescription,
          imagepathofPost: null,
          time: DateTime.now());

      await PostFunctions().uploadDescriptionAndImage(postModel: postModel);
      BlocProvider.of<BottomNavigationBloc>(context)
          .add(TabChange(tabIndex: 0));
    } else {
      BlocProvider.of<BottomNavigationBloc>(context)
          .add(TabChange(tabIndex: 0));
    }
    context.read<HomePageBloc>().add(UsersPostFetchEvent());
  }
}
