import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instanet/storage_method/storage_method.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firetsore = FirebaseFirestore.instance;

  Future<String> singUpuser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = 'some error occerred';
    try {
      if (email.isNotEmpty ||
              password.isNotEmpty ||
              username.isNotEmpty ||
              bio.isNotEmpty
          //  file != null
          ) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);
        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);
        await _firetsore.collection('user').doc(cred.user!.uid).set({
          'username': username,
          "uid": cred.user!.uid,
          "email": email,
          "bio": bio,
          "followers": [],
          "following": [],
          'photoUrl': photoUrl,
        });
        res = "success";
      }
    }
    // on FirebaseAuthException catch (err) {
    //   if (err.code == 'invalid-email') {
    //     res = 'The email is badly formatted.';
    //   } else {
    //     if (err.code == 'weak-password') {
    //       res = 'password should be al least 6 characters';
    //     }
    //   }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  // login to user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = "please enter all the fields";
      } 
    } 
      //  on FirebaseAuthException catch (err) {
      // if (err.code == 'user-not-found') {
      //   res = 'The email is badly formatted.';
      // } else {
      //   if (err.code == 'weak-password') {
      //     res = 'password should be al least 6 characters';
      //   }
      // }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }
}
