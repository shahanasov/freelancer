import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class PostFunctions {
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  File imagetoPost = File('');
  String? imagepath;

  Future<XFile?> imageSelect() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    return pickedImage;
  }

  Future<File> convertUint8ListToFile(Uint8List imageBytes) async {
    final tempDir = await getTemporaryDirectory();
    imagetoPost = await File('${tempDir.path}/edited_image.png').create();
    imagetoPost.writeAsBytesSync(imageBytes);
    return imagetoPost;
  }

  Future<String> uploadImageToFirebase(File imageFile) async {
    final storageRef =
        FirebaseStorage.instance.ref().child('Posts/${DateTime.now()}.jpg');
    final uploadTask = await storageRef.putFile(imageFile);
    return await storageRef.getDownloadURL(); // Return the image download URL
  }

  getCurrentUserPosts() async {
    // FirebaseFirestore.instance.clearPersistence();

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Posts")
          .where('userId', isEqualTo: userId)
          .orderBy('time', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => PostModel.fromSnapshot(doc))
          .toList();
    }on FirebaseException catch (e) {
      print(e.toString());
      return e;
    }
  }

  getAllUsersPost() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('Posts').orderBy('time',descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => PostModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      // print(e);
      return e;
    }
  }

  Future<void> uploadDescriptionAndImage({required PostModel postModel}) async {
    String? imagePathToSave = await uploadImageToFirebase(
        File(postModel.imagepathofPost!)); // Upload the image and get the path
    final postId = FirebaseFirestore.instance.collection('Posts').doc().id;
    postModel.postId = postId;
    final posts = FirebaseFirestore.instance.collection("Posts");

    try {
      // Create a new PostModel instance with the image path and description
      final newPost = PostModel(
        postId: postId,
        userId: userId,
        time: DateTime.now(), // Set current time
        imagepathofPost: imagePathToSave, // Save the new image path
        postDescription: postModel.postDescription, // Save the description
      ).tojson();

      // Add the new post to Firestore under the user's ID
      await posts.doc(postId).set(newPost);
    } catch (e) {
      print('Error uploading new post: $e');
    }
  }
}
