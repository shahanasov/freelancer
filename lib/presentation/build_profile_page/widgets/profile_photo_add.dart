import 'dart:io';
import 'package:flutter/material.dart';
import 'package:freelance/theme/color.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePhoto extends StatefulWidget {
  final XFile? imagetoPost;
  final Function(XFile?)
      onImageSelected; // Callback function to communicate with parent widget

  ProfilePhoto({super.key, this.imagetoPost, required this.onImageSelected});

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.imagetoPost; // Initialize with passed image if any
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        XFile? selectedImage = await imageSelect();
        if (selectedImage != null) {
          setState(() {
            _selectedImage = selectedImage; // Update local state
          });
          widget.onImageSelected(
              selectedImage); // Pass selected image to parent widget
        }
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: _selectedImage == null
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
                    backgroundImage: FileImage(
                      File(_selectedImage!.path),
                    ),
                  ),
          ),
          Icon(
            Icons.add_a_photo_outlined,
            color: white,
          ),
        ],
      ),
    );
  }

  Future<XFile?> imageSelect() async {
    final ImagePicker imagePicker = ImagePicker();
    try {
      final XFile? pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        print('Image selected: ${pickedImage.path}');
      } else {
        print('No image selected.');
      }
      return pickedImage;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }
}
