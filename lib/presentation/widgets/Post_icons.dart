import 'package:flutter/material.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/db/model/user_and_post_model.dart';
import 'package:freelance/db/model/user_details.dart';
import 'package:freelance/db/services/post_functions.dart';
import 'package:freelance/presentation/pages/home/widgets/like_button.dart';
import 'package:freelance/presentation/pages/message_page/chat/personal_chat.dart';

class PostIcons extends StatelessWidget {
  final PostModel postModel;
  final String userId;
  final UserDetailsModel userDetailsModel;
  const PostIcons({super.key, required this.postModel,required this.userId,required this.userDetailsModel});

  @override
  Widget build(BuildContext context) {
     final likeCountNotifier = ValueNotifier<int>(
                       postModel.likes.length);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            LikeButton(
              isLiked:
                 postModel.likes.contains(userId),
              postModel: postModel,
              onLikeToggled: () {
                final currentLikes =
                  postModel.likes.length;
                if (postModel.likes.contains(userId)) {
                  likeCountNotifier.value = currentLikes - 1;
                } else {
                  likeCountNotifier.value = currentLikes + 1;
                }
              },
            ),
            const SizedBox(
              width: 15,
            ),
            ValueListenableBuilder<int>(
                valueListenable: likeCountNotifier,
                builder: (context, likeCount, child) {
                  if (likeCount == 0) {
                    return const SizedBox();
                  }
                  return Text("$likeCount likes");
                }),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {
            PostFunctions()
                .sharePost(postModel.postId!);
          },
        ),
        GestureDetector(
            onTap: () {
              // NotificationFunctions().initNotifications();
              // PostFunctions().shareToChat(state
              // .posts[index].postModel.imagepathofPost!);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatPage(
                        recieverEmail:
                            postModel.userId!,
                        recieverId: postModel.userId!,
                        user: userDetailsModel,
                        message:
                            '${postModel.postDescription}/n I like to request about your services',
                      )));
            },
            child: const Icon(Icons.question_answer))
      ],
    );
  }
}
