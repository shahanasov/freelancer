import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final String? userId = FirebaseAuth.instance.currentUser?.uid;

  Future<User?> addUsersWithEmail(String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return null;
    }
  }

  // Future<User?>
  loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  signOut() async {
    //  await GoogleSignIn().signOut();
    await auth.signOut();
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? guser = await GoogleSignIn().signIn();
      log((guser?.email).toString());
      if (guser == null) {
        return null;
      }
      final GoogleSignInAuthentication gauth = await guser.authentication;

      final cred = GoogleAuthProvider.credential(
          idToken: gauth.idToken, accessToken: gauth.accessToken);

      return FirebaseAuth.instance.signInWithCredential(cred);
    } on FirebaseException catch (e) {
      log(e.code);
      return null;
    }
  }
}
