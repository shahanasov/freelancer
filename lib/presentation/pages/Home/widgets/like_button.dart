import 'package:flutter/material.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:freelance/db/services/post_functions.dart';

class LikeButton extends StatefulWidget {
  final bool isLiked;
  final PostModel postModel;

  const LikeButton({super.key, required this.isLiked, required this.postModel});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late bool isLiked;

  @override
  void initState() {
    isLiked = widget.isLiked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLiked = !isLiked;
        });
        PostFunctions().postLike(isLiked, widget.postModel);
      },
      child: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border, // Use the updated state
        color: isLiked ? Colors.red : Colors.grey, // Optional: change color based on state
      ),
    );
  }
}
