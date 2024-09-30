import 'package:flutter/material.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/presentation/pages/add_post_page/widgets/share_thoughts_widget.dart';
import 'package:freelance/presentation/pages/profile_page/profile.dart';
import '../../../../db/services/post_functions.dart';

class EditImageWidget extends StatelessWidget {
  const EditImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController sharethoughtsController =
        TextEditingController();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: const Icon(Icons.close),
          actions: [
            TextButton(
                onPressed: () async {
                  final postDescription = sharethoughtsController.text.trim();

                  PostModel postModel = PostModel(
                      likes: [],
                      postDescription: postDescription,
                      imagepathofPost: '',
                      time: DateTime.now());

                  await PostFunctions()
                      .uploadDescriptionAndImage(postModel: postModel);
                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ProfilePage()));
                },
                child: const Text('Done'))
          ],
        ),
        body: Body(
          sharethoughtsController: sharethoughtsController,
        ));
  }
}
