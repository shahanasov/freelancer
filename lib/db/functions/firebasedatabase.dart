import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:freelance/db/model/filesmodel.dart';
import 'package:freelance/db/model/userdetails.dart';

class UserDatabaseFunctions {
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  String? cvpath;

  Future buildProflieSaving(
      {required UserDetailsModel userdetailsmodel}) async {
    final userdetail =
        await FirebaseFirestore.instance.collection("UsersDetails");
    // String id = userdetail.doc().id;

    //  await firestore.collection('UsersDetails').doc("1").set(userdetails);
    final newUser = UserDetailsModel(
      id: userId,
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
    ).tojson();

    userdetail.doc(userId).set(newUser);
  }

  Future<UserDetailsModel?> gettingDetailsofTheUser() async {
    print(userId);
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
      print(e.code);
      return null;
    }
  }

  editDetailsofTheUser({required UserDetailsModel userdetailsmodel}) async {
    final userDetailDoc = FirebaseFirestore.instance;
    final updated = UserDetailsModel(
      id: userId,
      firstName: userdetailsmodel.firstName,
      lastName: userdetailsmodel.lastName,
      phone: userdetailsmodel.phone,
      gender: userdetailsmodel.gender,
      country: userdetailsmodel.country,
      state: userdetailsmodel.state,
      city: userdetailsmodel.city,
      dob: userdetailsmodel.dob,
      skills: userdetailsmodel.skills,
      services: userdetailsmodel.services,
      description: userdetailsmodel.description,
    ).tojson();

    await userDetailDoc.collection('UsersDetails').doc(userId).update(updated);
  }

  Future<FilesModel?> cvUpload({FilesModel? filesModel}) async {
    PlatformFile? pickedFile;
    final selectedfile = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
    if (selectedfile != null) {
      pickedFile = selectedfile.files.first;
      final path = '$userId/${pickedFile.name}';
      final file = File(pickedFile.path!);

      try {
        final ref = FirebaseStorage.instance.ref().child(path);

        UploadTask task = ref.putFile(file);
        TaskSnapshot snapshot = await task;
        cvpath = await snapshot.ref.getDownloadURL();
        // print('File uploaded successfully! Download URL: $pathstring');
        return FilesModel(
            resumeUrl: pickedFile.path,
            resumename: pickedFile.name,
            resumepath: cvpath); // Return the download URL if needed
      } catch (e) {
        print('Error uploading file: $e');
        return null;
      }
    } else {
      print('No file selected');
      return null;
    }
  }


  
  
}
