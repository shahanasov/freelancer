import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freelance/db/services/post_functions.dart';
import 'package:freelance/theme/color.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePhoto extends StatefulWidget {
  XFile? imagetoPost;
  ProfilePhoto({super.key, this.imagetoPost});

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        image = await PostFunctions().imageSelect();

        setState(() {});
      },
      child: Stack(
        alignment: Alignment.bottomRight, 
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: image == null
              ? CircleAvatar(
                  radius: 50,
                  child: Image.asset(
                    "assets/images/profilenew.jpg",
                    fit: BoxFit.fitWidth,
                  ),
                )
              : CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 50,
                  child: Image.file(
                    File(image!.path),
                    fit: BoxFit.fill,
                  ),
                ),
        ),
        Icon(
          Icons.add_a_photo_outlined,
          color: white,
        )
      ]),
    );
  }
}
