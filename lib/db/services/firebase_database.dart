import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:freelance/db/model/cv_pdf_model.dart';
import 'package:freelance/db/model/user_details.dart';

class UserDatabaseFunctions {
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  String? cvpath;
  // late File imagetoPost;

  Future buildProflieSaving(
      {required UserDetailsModel userdetailsmodel}) async {
    // print(userId);
    final userdetail = FirebaseFirestore.instance.collection("UsersDetails");

    final newUser = UserDetailsModel(
            id: userId!,
            firstName: userdetailsmodel.firstName,
            lastName: userdetailsmodel.lastName,
            description: userdetailsmodel.description,
            phone: userdetailsmodel.phone,
            gender: userdetailsmodel.gender,
            country: userdetailsmodel.country,
            state: userdetailsmodel.state,
            city: userdetailsmodel.city,
            dob: userdetailsmodel.dob,
            skills: userdetailsmodel.skills,
            services: userdetailsmodel.services,
            jobTitle: userdetailsmodel.jobTitle,
            follow: userdetailsmodel.follow,
            posts: userdetailsmodel.posts)
        .tojson();

    userdetail.doc(userId).set(newUser);
  }

  Future<UserDetailsModel?> gettingDetailsOfTheUser() async {
    // print(userId);
    if (userId == null) {
      throw Exception('User ID is null');
    }

    try {
      final userDetailDoc = await FirebaseFirestore.instance
          .collection('UsersDetails')
          .doc(userId)
          .get();

      if (userDetailDoc.exists) {
        return UserDetailsModel.fromSnapshot(userDetailDoc);
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      // print(e.code);
      return null;
    }
  }

  editDetailsOfTheUser({required UserDetailsModel userdetailsmodel}) async {
    final userDetailDoc = FirebaseFirestore.instance;
    final updated = UserDetailsModel(
            id: userId!,
            firstName: userdetailsmodel.firstName,
            lastName: userdetailsmodel.lastName,
            jobTitle: userdetailsmodel.jobTitle,
            phone: userdetailsmodel.phone,
            gender: userdetailsmodel.gender,
            country: userdetailsmodel.country,
            state: userdetailsmodel.state,
            city: userdetailsmodel.city,
            dob: userdetailsmodel.dob,
            skills: userdetailsmodel.skills,
            services: userdetailsmodel.services,
            description: userdetailsmodel.description,
            follow: userdetailsmodel.follow,
            posts: userdetailsmodel.posts
            )
        .tojson();

    await userDetailDoc.collection('UsersDetails').doc(userId).update(updated);
  }

  Future<ResumeModel?> cvUpload({ResumeModel? resumeModel}) async {
    PlatformFile? pickedFile;
    final selectedfile = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
    if (selectedfile != null) {
      pickedFile = selectedfile.files.first;
      final path = 'resume/${pickedFile.name}';
      final file = File(pickedFile.path!);

      try {
        final ref = FirebaseStorage.instance.ref().child(path);

        UploadTask task = ref.putFile(file);
        TaskSnapshot snapshot = await task;
        cvpath = await snapshot.ref.getDownloadURL();
        // print('File uploaded successfully! Download URL: $pathstring');
        return ResumeModel(
            userId: userId,
            resumeUrl: pickedFile.path,
            resumeName: pickedFile.name,
            resumePath: cvpath); // Return the download URL if needed
      } catch (e) {
        // print('Error uploading file: $e');
        return null;
      }
    } else {
      // print('No file selected');
      return null;
    }
  }

  Future<List<UserDetailsModel>?> getSearchResult(
      {DocumentSnapshot? start, required String querySearch}) async {
    Query user = FirebaseFirestore.instance
        .collection('UsersDetails')
        .where('jobTitle', isGreaterThanOrEqualTo: querySearch.toLowerCase())
        .where('jobTitle',
            isLessThanOrEqualTo: '${querySearch.toLowerCase()}\uf8ff');
    QuerySnapshot queryResult = await user.get();
    List<UserDetailsModel> userList =
        queryResult.docs.map((DocumentSnapshot document) {
      DocumentSnapshot<Map<String, dynamic>> doc =
          document as DocumentSnapshot<Map<String, dynamic>>;
      return UserDetailsModel.fromSnapshot(doc);
    }).toList();

    //to sort
    userList.sort((b, a) => a.firstName.compareTo(b.firstName));
    return userList;
  }

  Future<String> uploadProfilePhotoToFirebase(File imageFile) async {
    final storageRef =
        FirebaseStorage.instance.ref().child('profilephoto/$userId.jpg');
    // final uploadTask =
    await storageRef.putFile(imageFile);
    return await storageRef.getDownloadURL(); // Return the image download URL
  }

  Future<void> uploadResumetoDb({required ResumeModel resumeModel}) async {
    // Upload the image and get the path

    final postId = FirebaseFirestore.instance.collection('Resume').doc().id;

    final posts = FirebaseFirestore.instance.collection("Resume");

    try {
      // Create a new PostModel instance with the image path and description
      final newPost = ResumeModel(
              userId: userId,
              resumeUrl: resumeModel.resumeUrl,
              resumeName: resumeModel.resumeName,
              resumePath: resumeModel.resumePath)
          .tojson();

      // Add the new post to Firestore under the user's ID
      await posts.doc(postId).set(newPost);
    } catch (e) {
      // print('Error uploading new post: $e');
    }
  }

  Future<UserDetailsModel?> userDetails(String user) async {
    // print(userId);
    // if (user == null) {
    //   throw Exception('User ID is null');
    // }

    try {
      final userDetailDoc = await FirebaseFirestore.instance
          .collection('UsersDetails')
          .doc(user)
          .get();

      if (userDetailDoc.exists) {
        return UserDetailsModel.fromSnapshot(userDetailDoc);
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      // print(e.code);
      return null;
    }
  }

  following(bool isfollowed,String postId) {
    final ref =
        FirebaseFirestore.instance.collection('UsersDetails').doc(postId);
    if (isfollowed) {
      ref.update({
        'follow': FieldValue.arrayUnion([userId])
      });
      //       NotificationBloc().add(SendFollowNotification(
      //   followerId: postId,
      //    userId: userId!,
      // )
      // );

    } else {
      ref.update({
        'follow': FieldValue.arrayRemove([userId])
      });
    }
  }
  // posts(bool isPosted,String id) {
  //   final ref =
  //       FirebaseFirestore.instance.collection('UsersDetails').doc(id);
  //   if (isPosted) {
  //     ref.update({
  //       'posts': FieldValue.arrayUnion([userId])
  //     });
  //   } else {
  //     ref.update({
  //       'posts': FieldValue.arrayRemove([userId])
  //     });
  //   }
  // }
}
