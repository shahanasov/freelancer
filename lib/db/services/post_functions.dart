import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:freelance/db/model/post_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../model/user_and_post_model.dart';
import '../model/user_details.dart';

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

  Future<File> convertUint8ListToFile(Uint8List imageBytes,
      {required File image}) async {
        log('inside convert to file');
    final tempDir = await getTemporaryDirectory();
    final extension = image.path.split('.').last;
    log(extension);
    imagetoPost = File('${tempDir.path}/edited_image.$extension');
    await imagetoPost.writeAsBytes(imageBytes);
    log('converted');
    return imagetoPost;
  }

  Future<String> uploadImageToFirebase(File imageFile) async {
    final storageRef =
        FirebaseStorage.instance.ref().child('Posts/${DateTime.now()}.jpg');
    // final uploadTask =
    await storageRef.putFile(imageFile);
    return await storageRef.getDownloadURL(); // Return the image download URL
  }

  getCurrentUserPosts() async {
    // FirebaseFirestore.instance.clearPersistence();
    // print("current user $userId");
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Posts")
          .where('userId', isEqualTo: userId)
          .orderBy('time', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => PostModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      // print(e.toString());
      return e;
    }
  }

  Future<void> uploadDescriptionAndImage({required PostModel postModel}) async {
    String? imagePathToSave;
    if (postModel.imagepathofPost != null &&
        postModel.imagepathofPost!.isNotEmpty) {
      imagePathToSave =
          await uploadImageToFirebase(File(postModel.imagepathofPost!));
    }
    // Upload the image and get the path

    final postId = FirebaseFirestore.instance.collection('Posts').doc().id;
    postModel.postId = postId;
    final posts = FirebaseFirestore.instance.collection("Posts");

    try {
      // Create a new PostModel instance with the image path and description
      final newPost = PostModel(
        postId: postId,
        userId: userId,
        likes: [],
        time: DateTime.now(), // Set current time
        imagepathofPost: imagePathToSave, // Save the new image path
        postDescription: postModel.postDescription, // Save the description
      ).tojson();
      // UserDatabaseFunctions().posts(true, postId);
      // Add the new post to Firestore under the user's ID
      await posts.doc(postId).set(newPost);
    } catch (e) {
      // print('Error uploading new post: $e');
    }
  }

  Future<List<PostWithUserDetailsModel>> fetchPostAlongWithUser() async {
    QuerySnapshot<Map<String, dynamic>> postSnapshot = await FirebaseFirestore
        .instance
        .collection('Posts')
        .orderBy('time', descending: true)
        .get();

    List<PostWithUserDetailsModel> postswithUserDetails = [];

    for (var postDoc in postSnapshot.docs) {
      var postData = PostModel.fromSnapshot(postDoc);
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('UsersDetails')
              .doc(postData.userId)
              .get();
      UserDetailsModel userData = UserDetailsModel.fromSnapshot(userSnapshot);

      postswithUserDetails.add(PostWithUserDetailsModel(
          postModel: postData, userDetailsModel: userData));
    }

    return postswithUserDetails;
  }

  editPost(PostModel postModel) async {
    final updated = PostModel(
      postId: postModel.postId,
      userId: postModel.userId,
      likes: postModel.likes,
      time: postModel.time,
      imagepathofPost: postModel.imagepathofPost,
      postDescription: postModel.postDescription,
    ).tojson();
    await FirebaseFirestore.instance
        .collection('Posts')
        .doc(postModel.postId)
        .update(updated);
  }

  Future<List<PostModel>> getSpecificUserPosts(String? id) async {
    // FirebaseFirestore.instance.clearPersistence();
    // print("current user $id");
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Posts")
          .where('userId', isEqualTo: id)
          .orderBy('time', descending: true)
          .get();
      // print(querySnapshot.docs
      //     .map((doc) => PostModel.fromSnapshot(doc))
      //     .toList());
      return querySnapshot.docs
          .map((doc) => PostModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      log(e.toString());
      return [];
    }
  }

  deletePost(PostModel postModel) async {
    await FirebaseFirestore.instance
        .collection('Posts')
        .doc(postModel.postId)
        .delete();
    // UserDatabaseFunctions().posts(false, postModel.postId!);
  }

  void sharePost(String postId) async {
    DocumentSnapshot post =
        await FirebaseFirestore.instance.collection('Posts').doc(postId).get();

    if (post.exists) {
      String content = "${post['imagePathofPost']}\n${post['postDescription']}";
      Share.share(content, subject: 'New Post!');
    } else {
      // print('Post not found');
    }
  }

  postLike(bool isLiked, String postId) {
    final postref = FirebaseFirestore.instance.collection('Posts').doc(postId);
    if (isLiked) {
      postref.update({
        'likes': FieldValue.arrayUnion([userId])
      });
    } else {
      postref.update({
        'likes': FieldValue.arrayRemove([userId])
      });
    }
  }

  // void shareToChat(String content) {
  //   SocialShare.shareOptions(content);
  // }
}
