import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  // Future<User?>
  signinwithEmailandPassword(String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      // print('error duirng sign in :$e');
      return e;
    }
  }

  signOut() async {
    //  await GoogleSignIn().signOut();
    await auth.signOut();
  }

  signInwithGoogle() async {
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

//  userCheckingIfnewornot(){
// ref.once().then((DatabaseEvent event) {
//  DataSnapshot snapshot=event.snapshot;
//  if(!snapshot.exists){
//   ref.set({'isnew':true});
//  }else{
//   bool isNew =snapshot.value?['isnew']?? false;
//  }
// });
//  }
}
