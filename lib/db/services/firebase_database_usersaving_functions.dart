import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:freelance/db/model/cv_pdf_model.dart';
import 'package:freelance/db/model/notification_model.dart';
import 'package:freelance/db/model/user_and_post_model.dart';
import 'package:freelance/db/model/user_details.dart';
import 'package:freelance/db/services/notification_functions.dart';
import 'package:freelance/db/services/post_functions.dart';

class UserDatabaseFunctions {
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  String? cvpath;
  // late File imagetoPost;

  Future buildProflieSaving(
      {required UserDetailsModel userdetailsmodel}) async {
    // String? profilePic;

    // print(userId);
    final userdetail = FirebaseFirestore.instance.collection("UsersDetails");

    final newUser = UserDetailsModel(
            id: userId!,
            profilePhoto: userdetailsmodel.profilePhoto,
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

  Future<String> uploadProfilePhotoToFirebase(File imageFile) async {
    print("${imageFile.path} imageuploading");
    final storageRef =
        FirebaseStorage.instance.ref().child('profilephoto/$userId.jpg');
    // final uploadTask =
    await storageRef.putFile(imageFile);
    return await storageRef.getDownloadURL(); // Return the image download URL
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
      log(e.code);
      return null;
    }
  }

  editDetailsOfTheUser({required UserDetailsModel userdetailsmodel}) async {
    final userDetailDoc = FirebaseFirestore.instance;
    final updated = UserDetailsModel(
            id: userId!,
            profilePhoto: userdetailsmodel.profilePhoto,
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
            posts: userdetailsmodel.posts)
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

   Future<List<UserDetailsModel>?> getSearchResult({
    DocumentSnapshot? start,
    required String querySearch,
  }) async {
    // Fetching data from Firestore
    Query user = FirebaseFirestore.instance.collection('UsersDetails');
    QuerySnapshot queryResult = await user.get();

    // Mapping Firestore documents to UserDetailsModel
    List<UserDetailsModel> userList =
        queryResult.docs.map((DocumentSnapshot document) {
      DocumentSnapshot<Map<String, dynamic>> doc =
          document as DocumentSnapshot<Map<String, dynamic>>;
      return UserDetailsModel.fromSnapshot(doc);
    }).toList();

    // Filtering based on the search query
    List<UserDetailsModel> filteredList = userList.where((user) {
      final nameMatch =
          user.firstName.toLowerCase().contains(querySearch.toLowerCase());
      final jobMatch =
          user.jobTitle.toLowerCase().contains(querySearch.toLowerCase());
      final skillsMatch = user.skills.any(
          (skill) => skill.toLowerCase().contains(querySearch.toLowerCase()));
      final servicesMatch = user.services.any((services) =>
          services.toLowerCase().contains(querySearch.toLowerCase()));
      // Add other fields like skills or services if needed
      return nameMatch || jobMatch || skillsMatch || servicesMatch;
    }).toList();

    // Sorting the filtered list by firstName in descending order
    filteredList.sort((a, b) => a.firstName.compareTo(b.firstName));

    // Returning the sorted, filtered list
    return filteredList;
  }

  Future<void> uploadResumetoDb({required ResumeModel resumeModel}) async {
    // Upload the image and get the path

    // final postId = FirebaseFirestore.instance.collection('Resume').doc().id;

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
      await posts.doc(userId).set(newPost);
    } catch (e) {
      // print('Error uploading new post: $e');
    }
  }

  Future<ResumeModel?> getResume(String userId) async {
    try {
      final resumeDoc = await FirebaseFirestore.instance
          .collection('Resume')
          .doc(userId)
          .get();
      if (resumeDoc.exists) {
        final resume = ResumeModel.fromSnapshot(resumeDoc);

        return resume;
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      log(e.code);
      return null;
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
      log(e.code);
      return null;
    }
  }

  following(bool isfollowed, String postId) {
    final ref =
        FirebaseFirestore.instance.collection('UsersDetails').doc(postId);
    if (isfollowed) {
      ref.update({
        'follow': FieldValue.arrayUnion([userId]),
      });
      final request = FollowRequest(
          followerId: postId,
          fromUserName: '',
          userId: FirebaseAuth.instance.currentUser!.uid,
          timestamp: DateTime.now());
      NotificationFunctions().followRequest(request);
    } else {
      ref.update({
        'follow': FieldValue.arrayRemove([userId])
      });
    }
  }
}
