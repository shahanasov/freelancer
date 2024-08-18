import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:freelance/db/model/userdetails.dart';

class Authentication {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final String? userId = FirebaseAuth.instance.currentUser?.uid;

  Future<User?> createwithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      // print('Error during sign up:$e');
      return null;
    }
  }

  Future<User?> signinwithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      // print('error duirng sign in :$e');
      return null;
    }
  }

  signOut() {
    auth.signOut();
  }

  Future buildProflieSaving(
      {required UserDetailsModel userdetailsmodel}) async {
    final userdetail = FirebaseFirestore.instance.collection("UsersDetails");
    // String id = userdetail.doc().id;
    // final String? userId = FirebaseAuth.instance.currentUser?.uid;

    //  await firestore.collection('UsersDetails').doc("1").set(userdetails);
    final newUser = UserDetailsModel(
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
    ).tojson();

    userdetail.doc(userId).set(newUser);
  }

  Future<UserDetailsModel?> gettingDetailsofTheUser() async {
    // final String? userId = FirebaseAuth.instance.currentUser?.uid;

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
    } catch (e) {
      // print(e);
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
    ).tojson();

    userDetailDoc.collection('UsersDetails').doc(userId).update(updated);
  }
}
